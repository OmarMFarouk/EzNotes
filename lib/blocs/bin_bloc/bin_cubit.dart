import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/note_view.dart';
import '../../models/note_model.dart';
import '../../src/app_db.dart';
import '../../src/app_shared.dart';
import 'bin_states.dart';

class BinCubit extends Cubit<BinStates> {
  BinCubit() : super(BinInitial());
  static BinCubit get(context) => BlocProvider.of(context);
  List<NoteModel> notesBin = [];
  List<NoteModel> selectedNotes = [];
  final dbInstance = AppDB.database;
  bool selectionEnabled = false;
  int crossAxisCount = AppShared.localStorage.getInt('axisCount') ?? 2;
  double childAspectRatio =
      AppShared.localStorage.getDouble('childAspect') ?? 0.588;
  String notesView = AppShared.localStorage.getString('noteView') ?? 'GridView';
  Future<void> fetchBin() async {
    emit(BinInitial());
    notesBin.clear();
    await dbInstance!.rawQuery(
        'SELECT * FROM notes WHERE note_status = ? ORDER BY note_id DESC',
        ['deleted']).then((v) {
      for (var note in v) {
        notesBin.add(NoteModel.fromJson(note));
      }
    });
    emit(BinSuccess());
  }

  Future<void> deleteNote() async {
    emit(BinInitial());

    for (var i = 0; i < selectedNotes.length; i++) {
      dbInstance!.rawQuery(
          'DELETE FROM notes WHERE note_id = ? ', [selectedNotes[i].noteId]);
    }
    toogleSelectionMode();
    fetchBin();
  }

  void toogleSelectionMode() {
    selectionEnabled = !selectionEnabled;
    selectedNotes.clear();
    refreshState();
  }

  void selectNote(context, index) {
    if (selectionEnabled == true) {
      if (selectedNotes.contains(notesBin[index])) {
        selectedNotes.removeWhere((e) => e == notesBin[index]);
      } else {
        selectedNotes.add(notesBin[index]);
      }
    }
    refreshState();
  }

  void selectAllBin() {
    if (selectedNotes.isEmpty) {
      for (var i = 0; i < notesBin.length; i++) {
        selectedNotes.add(notesBin[i]);
      }
    } else {
      selectedNotes.clear();
    }
    refreshState();
  }

  void toggleView(Enum newView) {
    switch (newView) {
      case NotesViewEnum.gridView:
        childAspectRatio = 0.588;
        crossAxisCount = 2;
      case NotesViewEnum.listView:
        childAspectRatio = 1.588;
        crossAxisCount = 1;
    }
    notesView = newView.toString();
    refreshState();
  }

  void refreshState() {
    emit(BinRefresh());
  }
}
