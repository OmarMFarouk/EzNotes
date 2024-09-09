import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/note_bloc/notes_cubit.dart';

import '../../src/app_colors.dart';

class AddNoteHeader extends StatelessWidget {
  const AddNoteHeader(
      {super.key, required this.controller, required this.onSave});
  final TextEditingController controller;
  final VoidCallback onSave;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.titleText,
            size: 30,
          ),
        ),
        Expanded(
            child: TextField(
          controller: controller,
          onChanged: (value) =>
              BlocProvider.of<NotesCubit>(context).refreshState(),
          style: const TextStyle(
              color: AppColors.titleText,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: AppColors.subTitleText,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              hintText: 'Title...'),
        )),
        IconButton(
          onPressed: controller.text.isEmpty ? () {} : onSave,
          icon: Icon(
            Icons.save_outlined,
            color: controller.text.isNotEmpty
                ? AppColors.titleText
                : AppColors.subTitleText,
            size: 30,
          ),
        ),
      ],
    );
  }
}
