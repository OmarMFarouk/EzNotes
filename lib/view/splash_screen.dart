import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/bin_bloc/bin_cubit.dart';
import 'package:notes/blocs/home_bloc/home_cubit.dart';
import 'package:notes/src/app_colors.dart';
import 'package:notes/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<BinCubit>(context).fetchBin();
    BlocProvider.of<HomeCubit>(context).fetchNotes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backGround,
    );
  }
}
