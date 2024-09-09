import 'package:flutter/material.dart';

import '../../models/note_model.dart';
import 'note_box.dart';

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({super.key, required this.notesList, this.cubit});
  final List<NoteModel> notesList;
  final cubit;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemCount: notesList.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cubit.crossAxisCount,
            childAspectRatio: cubit.childAspectRatio,
            mainAxisSpacing: 50,
            crossAxisSpacing: 20),
        itemBuilder: (context, index) => NoteBox(
            noteDetails: cubit.allNotes[index],
            isSelected: cubit.selectedNotes.contains(cubit.allNotes[index]),
            onLongTap: () => cubit.toogleSelectionMode(),
            selectionMode: cubit.selectionEnabled,
            onTap: () => cubit.selectNote(context, index)));
  }
}
