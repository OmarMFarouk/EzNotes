import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/blocs/home_bloc/home_states.dart';
import 'package:notes/components/home_screen/note_box.dart';
import 'package:notes/src/app_colors.dart';
import '../components/home_screen/appBar.dart';
import '../components/general/drawer.dart';
import '../components/home_screen/floatingAB.dart';
import '../components/home_screen/filter_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
              floatingActionButton: const MyFloatingAB(),
              backgroundColor: AppColors.backGround,
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: HomeAppBar(
                  selectedCount: cubit.selectedNotes.length,
                  onCancel: () => cubit.toogleSelectionMode(),
                  onDelete: () => cubit.deleteNote(),
                  onSelectAll: () => cubit.selectAllNotes(),
                  selectionMode: cubit.selectionEnabled,
                ),
              ),
              drawer: cubit.selectionEnabled ? null : const MyDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const FilterTile(),
                    const SizedBox(height: 15),
                    cubit.allNotes.isEmpty
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
                            itemCount: cubit.allNotes.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: cubit.crossAxisCount,
                                    childAspectRatio: cubit.childAspectRation,
                                    mainAxisSpacing: 50,
                                    crossAxisSpacing: 20),
                            itemBuilder: (context, index) => NoteBox(
                                noteDetails: cubit.allNotes[index],
                                isSelected: cubit.selectedNotes
                                    .contains(cubit.allNotes[index]),
                                onLongTap: () => cubit.toogleSelectionMode(),
                                selectionMode: cubit.selectionEnabled,
                                onTap: () => cubit.selectNote(context, index)))
                  ],
                ),
              ));
        });
  }
}
