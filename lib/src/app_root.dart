import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/bin_bloc/bin_cubit.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/blocs/note_bloc/notes_cubit.dart';
import 'package:notes/view/home_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NotesCubit()),
          BlocProvider(create: (context) => BinCubit()..fetchBin()),
          BlocProvider(create: (context) => HomeCubit()..fetchNotes())
        ],
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Cairo'),
          title: 'Notes',
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
