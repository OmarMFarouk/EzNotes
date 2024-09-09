import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/blocs/note_bloc/notes_states.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/src/app_db.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitial());
  static NotesCubit get(context) => BlocProvider.of(context);
  TextEditingController titleCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();
  final List<String> undoStack = [];
  final List<String> redoStack = [];
  final dbInstance = AppDB.database;
  int noteFS = 16;

  Future<void> saveNote(context) async {
    emit(NotesInitial());
    NoteModel note = NoteModel(
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
        fontSize: noteFS,
        noteBody: noteCont.text,
        noteTitle: titleCont.text,
        noteStatus: 'normal');
    await dbInstance!.rawQuery(
        'INSERT INTO notes(note_title, note_body, note_status , note_fontSize, note_dateCreated, note_dateModified) VALUES(?, ?, ?, ?, ?, ?)',
        [
          note.noteTitle,
          note.noteBody,
          note.noteStatus,
          note.fontSize,
          note.dateCreated!.toIso8601String(),
          note.dateModified!.toIso8601String()
        ]).whenComplete(() {
      emit(NotesAdded());
      HomeCubit.get(context).fetchNotes();
      noteCont.clear();
      titleCont.clear();
      redoStack.clear();
      undoStack.clear();
    });
  }

  void changeTextSize({required bool willIncrease}) {
    if (willIncrease) {
      noteFS != 64 ? noteFS++ : null;
    } else {
      noteFS != 16 ? noteFS-- : null;
    }
    refreshState();
  }

  void undo() {
    if (undoStack.isNotEmpty) {
      redoStack.add(undoStack.last);
      noteCont.text =
          undoStack.removeLast(); // Check if the first word was removed
    }
    refreshState();
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(noteCont.text);
      noteCont.text = redoStack.removeLast();
    }
    refreshState();
  }

  void refreshState() {
    emit(NotesRefresh());
  }
}
