import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../src/app_colors.dart';
import '../add_note_scren/buttons.dart';

class BinAppBar extends StatelessWidget {
  const BinAppBar(
      {super.key,
      required this.selectionMode,
      required this.onCancel,
      required this.onDelete,
      required this.onSelectAll,
      required this.selectedCount});
  final bool selectionMode;
  final VoidCallback onCancel, onDelete, onSelectAll;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColors.titleText),
      title: selectionMode
          ? Row(
              children: [
                AddNoteButton(onTap: onCancel, icon: Icons.cancel_outlined),
                const Spacer(),
                Text(
                  '$selectedCount Selected',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                const Spacer(),
                AddNoteButton(onTap: onSelectAll, icon: Icons.select_all_sharp),
                AddNoteButton(onTap: onDelete, icon: Icons.delete)
              ],
            )
          : Row(
              children: [
                const Text(
                  'Recycle bin',
                  style: TextStyle(
                      color: AppColors.titleText,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ))
              ],
            ),
    );
  }
}
