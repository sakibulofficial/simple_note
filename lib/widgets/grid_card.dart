import 'package:flutter/material.dart';
import '../models/notes.dart';
import '../values/app_style.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    super.key,
    required this.note,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });
  final Note note;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(note.backgroundColor).withOpacity(0.40),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
            Text(
              note.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              style: bodyTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
