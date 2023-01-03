import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes.dart';

class NoteDB {
  final String dbName;
  Database? _db;
  List<Note> _notes = [];
  final _streamController = StreamController<List<Note>>.broadcast();

  NoteDB({required this.dbName});

  Future<List<Note>> _fatchNotes() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query(
        'NOTE',
        distinct: true,
        columns: [
          'ID',
          'TITLE',
          'DESCRIPTION',
          'BACKGROUNDCOLOR',
        ],
        orderBy: 'ID',
      );

      final notes = read.map((row) => Note.fromRow(row)).toList();
      return notes;
    } catch (e) {
      debugPrint('ERROR : $e');
      return [];
    }
  }

  Future<bool> update(Note note) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      final updateCount = await db.update(
        'NOTE',
        {
          'TITLE': note.title,
          'DESCRIPTION': note.description,
          'BACKGROUNDCOLOR': note.backgroundColor,
        },
        where: 'ID = ?',
        whereArgs: [note.id],
      );
      if (updateCount == 1) {
        _notes.removeWhere((other) => other.id == note.id);
        _notes.add(note);
        debugPrint(_notes.toString());
        _streamController.add(_notes);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("error $e");
      return false;
    }
  }

  Future<bool> create(
    String title,
    String description,
    int backgroundColor,
  ) async {
    final db = _db;
    if (db == null) {
      return false;
    }

    try {
      final id = await db.insert('NOTE', {
        'TITLE': title,
        'DESCRIPTION': description,
        'BACKGROUNDCOLOR': backgroundColor,
      });

      final person = Note(
        id: id,
        title: title,
        description: description,
        backgroundColor: backgroundColor,
      );
      _notes.add(person);
      _streamController.add(_notes);

      return true;
    } catch (e) {
      debugPrint('created : $e');
      return false;
    }
  }

  Future<bool> delete(Note note) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final deletedCount = await db.delete(
        'NOTE',
        where: 'ID = ?',
        whereArgs: [note.id],
      );

      if (deletedCount == 1) {
        _notes.remove(note);
        _streamController.add(_notes);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error : $e");
      return false;
    }
  }

  Future<bool> open() async {
    if (_db != null) {
      return true;
    }
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$dbName';

    try {
      final db = await openDatabase(path);
      _db = db;

      await db.execute(
          'CREATE TABLE IF NOT EXISTS NOTE (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, DESCRIPTION TEXT, BACKGROUNDCOLOR INTEGER)');

      _notes = await _fatchNotes();
      _streamController.add(_notes);

      return true;
    } catch (e) {
      debugPrint('Error : $e');
      return false;
    }
  }

  Future<bool> close() async {
    final db = _db;
    if (db == null) {
      return false;
    }

    await db.close();
    return true;
  }

  Stream<List<Note>> all() => _streamController.stream.map(
        (notes) => notes..sort(),
      );

  List<Note> getnNote() {
    return _notes;
  }
}
