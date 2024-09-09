import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/note_bloc/notes_cubit.dart';
import 'package:notes/blocs/note_bloc/notes_states.dart';
import 'package:notes/components/add_note_scren/buttons.dart';
import 'package:notes/components/add_note_scren/header.dart';
import 'package:notes/components/add_note_scren/note_field.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/src/app_colors.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, this.noteDetails});
  final NoteModel? noteDetails;
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    if (widget.noteDetails != null) {
      BlocProvider.of<NotesCubit>(context).titleCont.text =
          widget.noteDetails!.noteTitle!;
      BlocProvider.of<NotesCubit>(context).noteFS =
          widget.noteDetails!.fontSize!;
      BlocProvider.of<NotesCubit>(context).noteCont.text =
          widget.noteDetails!.noteBody!;
    } else if (widget.noteDetails == null) {
      BlocProvider.of<NotesCubit>(context).titleCont.clear();
      BlocProvider.of<NotesCubit>(context).noteCont.clear();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesStates>(listener: (context, state) {
      if (state is NotesAdded) {
        showDialog(
            barrierDismissible: false,
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'كلو اليصطة',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/images/success.png'),
                    ],
                  ),
                ));
        Future.delayed(const Duration(milliseconds: 750), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    }, builder: (context, state) {
      var cubit = NotesCubit.get(context);
      return Scaffold(
        backgroundColor: AppColors.backGround,
        body: Column(
          children: [
            AddNoteHeader(
                controller: cubit.titleCont,
                onSave: () {
                  if (widget.noteDetails != null) {
                    cubit.updateNote(context, widget.noteDetails!.noteId);
                  } else {
                    cubit.saveNote(context);
                  }
                }),
            const Divider(
              thickness: 0.3,
            ),
            NoteField(
                onChanged: (text) {
                  cubit.undoStack.add(text);
                  cubit.redoStack.clear();
                  cubit.refreshState();
                },
                controller: cubit.noteCont,
                fontSize: cubit.noteFS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddNoteButton(
                    icon: Icons.text_increase_outlined,
                    onTap: () => cubit.changeTextSize(willIncrease: true)),
                AddNoteButton(
                    icon: Icons.text_decrease_outlined,
                    onTap: () => cubit.changeTextSize(willIncrease: false)),
                AddNoteButton(
                    icon: Icons.undo_outlined, onTap: () => cubit.undo()),
                AddNoteButton(
                    icon: Icons.redo_outlined, onTap: () => cubit.redo())
              ],
            )
          ],
        ),
      );
    });
  }
}
