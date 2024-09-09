import 'package:flutter/material.dart';

import '../../src/app_colors.dart';
import '../../view/note_screen.dart';

class MyFloatingAB extends StatelessWidget {
  const MyFloatingAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add a note',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      backgroundColor: AppColors.titleText.withAlpha(65),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteScreen(),
          )),
      child: const Icon(
        Icons.add_circle_outline_outlined,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }
}
