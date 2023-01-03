import 'package:flutter/material.dart';
import '../data/note_db.dart';
import '../models/notes.dart';
import '../screens/create_update.dart';
import '../values/app_style.dart';

class ListCard extends StatelessWidget {
  final Note note;

  final NoteDB store;

  const ListCard({
    super.key,
    required this.note,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        store.delete(note);
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateUpdate(
              isUpdateScreen: true,
              note: note,
              store: store,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(note.backgroundColor).withOpacity(0.40),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: titleTextStyle,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              note.description,
              style: bodyTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
