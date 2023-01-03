// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../data/note_db.dart';
import 'list_card.dart';

class ListNotes extends StatelessWidget {
  final List notes;
  final NoteDB store;
  const ListNotes({
    required this.notes,
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListCard(
            note: notes[index],
            store: store,
          );
        },
      ),
    );
  }
}
