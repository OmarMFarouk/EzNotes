import 'package:flutter/material.dart';
import 'package:notes/models/note_model.dart';

import '../../src/app_colors.dart';

class NoteBox extends StatelessWidget {
  const NoteBox(
      {super.key,
      required this.noteDetails,
      required this.onTap,
      required this.onLongTap,
      required this.selectionMode,
      required this.isSelected});
  final NoteModel noteDetails;
  final bool selectionMode, isSelected;
  final VoidCallback onTap, onLongTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onLongPress: onLongTap,
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: AppColors.drawerBG.withAlpha(200),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    noteDetails.noteBody!,
                    style: const TextStyle(
                        color: AppColors.titleText, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 9,
                  ),
                ),
              ),
              Visibility(
                visible: selectionMode,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (s) {},
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            noteDetails.noteTitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.titleText,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            NoteModel().dateFormatter(noteDetails.dateModified!),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.subTitleText,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
