import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class NoteField extends StatelessWidget {
  const NoteField(
      {super.key,
      required this.onChanged,
      required this.controller,
      required this.fontSize});
  final void Function(String) onChanged;
  final TextEditingController controller;
  final int fontSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColors.drawerBG, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        cursorColor: AppColors.primary,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
              color: AppColors.subTitleText,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        style: TextStyle(
            color: AppColors.titleText,
            fontWeight: FontWeight.bold,
            fontSize: double.parse(fontSize.toString())),
        expands: true,
        maxLines: null,
        minLines: null,
      ),
    ));
  }
}
