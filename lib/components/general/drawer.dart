import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/bin_bloc/bin_cubit.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/src/app_constants.dart';
import 'package:notes/view/bin_screen.dart';
import 'package:notes/view/home_screen.dart';

import '../../src/app_colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerBG,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.subTitleText,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: AppConstants.drawerIndex == 0
                  ? AppColors.primary.withAlpha(100)
                  : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onTap: AppConstants.drawerIndex == 0
                  ? () {}
                  : () {
                      setState(() {
                        AppConstants.drawerIndex = 0;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    },
              contentPadding: const EdgeInsets.only(left: 25, right: 15),
              title: Row(
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: AppColors.titleText.withAlpha(150),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'All notes',
                    style: TextStyle(
                        color: AppColors.titleText,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    BlocProvider.of<HomeCubit>(context)
                        .allNotes
                        .length
                        .toString(),
                    style: const TextStyle(
                        color: AppColors.subTitleText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: AppConstants.drawerIndex == 1
                  ? AppColors.primary.withAlpha(100)
                  : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onTap: AppConstants.drawerIndex == 1
                  ? () {}
                  : () {
                      setState(() {
                        AppConstants.drawerIndex = 1;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BinScreen(),
                          ));
                    },
              contentPadding: const EdgeInsets.only(left: 25, right: 15),
              title: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.titleText.withAlpha(150),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Recycle bin',
                    style: TextStyle(
                        color: AppColors.titleText,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    BlocProvider.of<BinCubit>(context)
                        .notesBin
                        .length
                        .toString(),
                    style: const TextStyle(
                        color: AppColors.subTitleText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
