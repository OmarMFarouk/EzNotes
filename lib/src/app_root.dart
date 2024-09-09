import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/bin_bloc/bin_cubit.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/blocs/note_bloc/notes_cubit.dart';
import 'package:notes/view/home_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
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
