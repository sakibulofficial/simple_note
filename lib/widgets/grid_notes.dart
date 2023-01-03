// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_note/widgets/grid_card.dart';
import '../data/note_db.dart';
import '../screens/create_update.dart';

class GridNotes extends StatelessWidget {
  final List notes;
  final NoteDB store;
  const GridNotes({
    required this.notes,
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GridCard(
            note: notes[index],
            index: index,
            onLongPress: () {
              store.delete(notes[index]);
            },
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateUpdate(
                    isUpdateScreen: true,
                    note: notes[index],
                    store: store,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
