import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/screens/home_screen/bloc/theme_bloc/bloc/theme_bloc.dart';
import 'package:tic_tac_toe/screens/home_screen/view/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Theme Bloc to change between dark and light theme.
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
            theme: ThemeData(
                brightness:
                    state is DarkTheme ? Brightness.dark : Brightness.light),
          );
        },
      ),
    );
  }
}