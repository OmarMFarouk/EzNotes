import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/src/app_shared.dart';
import 'package:notes/view/note_screen.dart';
import '../../enums/home_view_enum.dart';
import '../../models/note_model.dart';
import '../../src/app_db.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int crossAxisCount = AppShared.localStorage.getInt('axisCount') ?? 2;
  double childAspectRation =
      AppShared.localStorage.getDouble('childAspect') ?? 0.588;
  List<NoteModel> allNotes = [];
  List<NoteModel> selectedNotes = [];
  final dbInstance = AppDB.database;
  bool selectionEnabled = false;
  String homeView = AppShared.localStorage.getString('homeView') ?? 'GridView';

  Future<void> fetchNotes() async {
    emit(HomeInitial());
    allNotes.clear();
    await dbInstance!.rawQuery(
        'SELECT * FROM notes WHERE note_status = ? ORDER BY note_id DESC',
        ['normal']).then((v) {
      for (var note in v) {
        allNotes.add(NoteModel.fromJson(note));
      }
    });
    emit(HomeSuccess());
  }

  Future<void> deleteNote() async {
    emit(HomeInitial());

    for (var i = 0; i < selectedNotes.length; i++) {
      dbInstance!.rawQuery(
          'UPDATE notes SET note_status = ? WHERE note_id = ? ',
          ['deleted', selectedNotes[i].noteId]);
    }
    toogleSelectionMode();
    fetchNotes();
  }

  void toogleSelectionMode() {
    selectionEnabled = !selectionEnabled;
    selectedNotes.clear();
    refreshState();
  }

  void selectNote(context, index) {
    if (selectionEnabled == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteScreen(
              noteDetails: allNotes[index],
            ),
          ));
    } else {
      if (selectedNotes.contains(allNotes[index])) {
        selectedNotes.removeWhere((e) => e == allNotes[index]);
      } else {
        selectedNotes.add(allNotes[index]);
      }
    }
    refreshState();
  }

  void selectAllNotes() {
    if (selectedNotes.isEmpty) {
      for (var i = 0; i < allNotes.length; i++) {
        selectedNotes.add(allNotes[i]);
      }
    } else {
      selectedNotes.clear();
    }
    refreshState();
  }

  void toggleView(Enum newView) {
    switch (newView) {
      case HomeViewEnum.gridView:
        childAspectRation = 0.588;
        crossAxisCount = 2;
      case HomeViewEnum.listView:
        childAspectRation = 1.588;
        crossAxisCount = 1;
    }
    homeView = newView.toString();
    refreshState();
  }

  void reArrange() {
    allNotes = allNotes.reversed.toList();
    refreshState();
  }

  void refreshState() {
    emit(HomeRefresh());
  }
}
