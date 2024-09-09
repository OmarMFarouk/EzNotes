import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/enums/home_view_enum.dart';

import '../../src/app_colors.dart';
import '../add_note_scren/buttons.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar(
      {super.key,
      required this.selectionMode,
      required this.onCancel,
      required this.onDelete,
      required this.onSelectAll,
      required this.onSearch,
      required this.selectedCount});
  final bool selectionMode;
  final VoidCallback onCancel, onDelete, onSelectAll;
  final int selectedCount;
  final Function(String) onSearch;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool searchMode = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColors.titleText),
      title: widget.selectionMode
          ? Row(
              children: [
                AddNoteButton(
                    onTap: widget.onCancel, icon: Icons.cancel_outlined),
                const Spacer(),
                Text(
                  '${widget.selectedCount} Selected',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                const Spacer(),
                AddNoteButton(
                    onTap: widget.onSelectAll, icon: Icons.select_all_sharp),
                AddNoteButton(onTap: widget.onDelete, icon: Icons.delete)
              ],
            )
          : Row(
              children: [
                const Text(
                  'All notes',
                  style: TextStyle(
                      color: AppColors.titleText,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                AnimatedContainer(
                  width: searchMode
                      ? MediaQuery.sizeOf(context).width * 0.4
                      : MediaQuery.sizeOf(context).width * 0.1,
                  curve: Curves.decelerate,
                  duration: Durations.short4,
                  child: searchMode
                      ? TextField(
                          onChanged: widget.onSearch,
                          onSubmitted: (value) {
                            setState(() {
                              searchMode = !searchMode;
                            });
                          },
                          cursorColor: AppColors.primary,
                          style: const TextStyle(color: AppColors.titleText),
                          decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: const TextStyle(
                                  color: AppColors.subTitleText),
                              filled: true,
                              fillColor: AppColors.drawerBG,
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchMode = !searchMode;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.search_off_outlined,
                                    color: AppColors.subTitleText,
                                    size: 25,
                                  ))),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              searchMode = !searchMode;
                            });
                          },
                          icon: const Icon(
                            Icons.search_outlined,
                          )),
                ),
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
                                            .toggleView(HomeViewEnum.gridView),
                                        checked:
                                            BlocProvider.of<HomeCubit>(context)
                                                    .homeView ==
                                                HomeViewEnum.gridView
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
                                            .toggleView(HomeViewEnum.listView),
                                        padding: EdgeInsets.zero,
                                        checked:
                                            BlocProvider.of<HomeCubit>(context)
                                                    .homeView ==
                                                HomeViewEnum.listView
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
