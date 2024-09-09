import 'package:flutter/material.dart';

import '../../src/app_colors.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({super.key, required this.onTap, required this.icon});
  final VoidCallback onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: AppColors.primary,
      onPressed: onTap,
      icon: Icon(
        icon,
        color: AppColors.titleText,
        size: 25,
      ),
    );
  }
}
