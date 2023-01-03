import 'package:flutter/material.dart';
import '../data/note_db.dart';
import '../models/notes.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/list_card.dart';

class SearchScreen extends StatefulWidget {
  final NoteDB noteDB;
  const SearchScreen({
    required this.noteDB,
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Note> notes = [];
  void searchNotes(String query) {
    notes = widget.noteDB.getnNote().where((note) {
      final sarchLower = query.toLowerCase();
      final titleLower = note.title;

      return titleLower.contains(sarchLower);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isSearchBar: true,
        appBarTitle: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              searchNotes(value);
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search notes',
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => ListCard(
            note: notes[index],
            store: widget.noteDB,
          ),
        ),
      ),
    );
  }
}
