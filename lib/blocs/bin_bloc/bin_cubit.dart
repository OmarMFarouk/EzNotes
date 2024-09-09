import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/note_model.dart';
import '../../src/app_db.dart';
import 'bin_states.dart';

class BinCubit extends Cubit<BinStates> {
  BinCubit() : super(BinInitial());
  static BinCubit get(context) => BlocProvider.of(context);
  TextEditingController titleCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();
  final List<String> undoStack = [];
  final List<String> redoStack = [];
  List<NoteModel> notesBin = [];
  List<NoteModel> selectedBin = [];
  final dbInstance = AppDB.database;
  int noteFS = 16;
  bool selectionEnabled = false;

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

    for (var i = 0; i < selectedBin.length; i++) {
      dbInstance!.rawQuery(
          'DELETE FROM notes WHERE note_id = ? ', [selectedBin[i].noteId]);
    }
    toogleSelectionMode();
    fetchBin();
  }

  void changeTextSize({required bool willIncrease}) {
    if (willIncrease) {
      noteFS != 64 ? noteFS++ : null;
    } else {
      noteFS != 16 ? noteFS-- : null;
    }
    refreshState();
  }

  void toogleSelectionMode() {
    selectionEnabled = !selectionEnabled;
    selectedBin.clear();
    refreshState();
  }

  void selectNote(context, index) {
    if (selectionEnabled == true) {
      if (selectedBin.contains(notesBin[index])) {
        selectedBin.removeWhere((e) => e == notesBin[index]);
      } else {
        selectedBin.add(notesBin[index]);
      }
    }
    refreshState();
  }

  void selectAllBin() {
    if (selectedBin.isEmpty) {
      for (var i = 0; i < notesBin.length; i++) {
        selectedBin.add(notesBin[i]);
      }
    } else {
      selectedBin.clear();
    }
    refreshState();
  }

  void refreshState() {
    emit(BinRefresh());
  }
}
