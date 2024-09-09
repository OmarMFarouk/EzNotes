import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_bloc/home_cubit.dart';
import '../../enums/note_view.dart';
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
                    onPressed: () => showMenu(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: AppColors.subTitleText,
                            position: RelativeRect.fromDirectional(
                                textDirection: TextDirection.rtl,
                                start: 0,
                                top: 0,
                                end: 1,
                                bottom: 0),
                            context: context,
                            items: [
                              CheckedPopupMenuItem(
                                onTap: () => BlocProvider.of<HomeCubit>(context)
                                    .toogleSelectionMode(),
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: AppColors.titleText, fontSize: 18),
                                ),
                              ),
                              CheckedPopupMenuItem(
                                onTap: () => showMenu(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: AppColors.subTitleText,
                                    position: RelativeRect.fromDirectional(
                                        textDirection: TextDirection.rtl,
                                        start: 0,
                                        top: 0,
                                        end: 1,
                                        bottom: 0),
                                    context: context,
                                    items: [
                                      CheckedPopupMenuItem(
                                        onTap: () => BlocProvider.of<HomeCubit>(
                                                context)
                                            .toggleView(NotesViewEnum.gridView),
                                        checked:
                                            BlocProvider.of<HomeCubit>(context)
                                                    .notesView ==
                                                NotesViewEnum.gridView
                                                    .toString(),
                                        padding: EdgeInsets.zero,
                                        child: const Text(
                                          'Grid',
                                          style: TextStyle(
                                              color: AppColors.titleText,
                                              fontSize: 18),
                                        ),
                                      ),
                                      CheckedPopupMenuItem(
                                        onTap: () => BlocProvider.of<HomeCubit>(
                                                context)
                                            .toggleView(NotesViewEnum.listView),
                                        padding: EdgeInsets.zero,
                                        checked:
                                            BlocProvider.of<HomeCubit>(context)
                                                    .notesView ==
                                                NotesViewEnum.listView
                                                    .toString(),
                                        child: const Text(
                                          'List',
                                          style: TextStyle(
                                              color: AppColors.titleText,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ]),
                                padding: EdgeInsets.zero,
                                child: const Text(
                                  'View',
                                  style: TextStyle(
                                      color: AppColors.titleText, fontSize: 18),
                                ),
                              ),
                            ]),
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ))
              ],
            ),
    );
  }
}
