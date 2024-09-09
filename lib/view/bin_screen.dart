import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/bin_bloc/bin_cubit.dart';
import 'package:notes/blocs/bin_bloc/bin_states.dart';
import 'package:notes/components/bin_screen/appBar.dart';
import 'package:notes/components/home_screen/note_box.dart';
import 'package:notes/src/app_colors.dart';
import '../components/general/drawer.dart';
import '../components/home_screen/filter_tile.dart';

class BinScreen extends StatefulWidget {
  const BinScreen({super.key});

  @override
  State<BinScreen> createState() => _BinScreenState();
}

class _BinScreenState extends State<BinScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BinCubit, BinStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BinCubit.get(context);
          return Scaffold(
              backgroundColor: AppColors.backGround,
              appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, kToolbarHeight),
                  child: BinAppBar(
                    selectedCount: cubit.selectedBin.length,
                    onCancel: () => cubit.toogleSelectionMode(),
                    onDelete: () => cubit.deleteNote(),
                    onSelectAll: () => cubit.selectAllBin(),
                    selectionMode: cubit.selectionEnabled,
                  )),
              drawer: cubit.selectionEnabled ? null : const MyDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const FilterTile(),
                    const SizedBox(height: 15),
                    cubit.notesBin.isEmpty
                        ? const Center(
                            child: Text(
                              'nothing to show',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.subTitleText,
                                  wordSpacing: 5,
                                  letterSpacing: 5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            itemCount: cubit.notesBin.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.5 / 4.25,
                                    mainAxisSpacing: 50,
                                    crossAxisSpacing: 20),
                            itemBuilder: (context, index) => NoteBox(
                                noteDetails: cubit.notesBin[index],
                                isSelected: cubit.selectedBin
                                    .contains(cubit.notesBin[index]),
                                onLongTap: () => cubit.toogleSelectionMode(),
                                selectionMode: cubit.selectionEnabled,
                                onTap: () => cubit.selectNote(context, index)))
                  ],
                ),
              ));
        });
  }
}
