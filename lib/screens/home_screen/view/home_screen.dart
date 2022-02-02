import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tic_tac_toe/constants/style.dart';
import 'package:tic_tac_toe/extensions/extensions.dart';
import 'package:tic_tac_toe/screens/home_screen/bloc/home_screen_bloc/homescreen_bloc.dart';
import 'package:tic_tac_toe/screens/home_screen/bloc/theme_bloc/bloc/theme_bloc.dart';
import 'package:tic_tac_toe/screens/one_player_game_screen/view/game_screen.dart';
import 'package:tic_tac_toe/screens/two_player_game_screen/view/game_screen.dart';


import 'creating_game_dailog.dart';
import 'join_game_dailog.dart';
import 'option_dailog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(state is! DarkTheme));
                  },
                  icon: state is DarkTheme
                      ? const Icon(
                          Icons.light_mode,
                          color: Colors.orange,
                        )
                      : const Icon(
                          Icons.dark_mode,
                          color: Colors.black,
                        ));
            },
          )
        ],
      ),
      body: BlocProvider<HomeScreenBloc>(
        create: (context) {
          return HomeScreenBloc();
        },
        child: BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is ShowOptionDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return BlocProvider.value(
                      value: BlocProvider.of<HomeScreenBloc>(context),
                      child: const OptionDailog(),
                    );
                  });
            } else if (state is ShowJoinGameDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return const JoinGameDailog();
                  });
            } else if (state is ShowCreatingGameDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return const CreatingGameDailog();
                  });
            }
          },
          child: const HomeScreenView(),
        ),
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OnePlayerGameScreen()));
          },
          child: Text("One Player",
              style: Theme.of(context).textTheme.headline6?.boldText),
        ),
        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TwoPlayerGameScreen()));
          },
          child: Text("Two Player",
              style: Theme.of(context).textTheme.headline6?.boldText),
        )
        //TODO : make game play online

        // ElevatedButton(
        //     onPressed: () {
        //       BlocProvider.of<HomeScreenBloc>(context)
        //           .add(ShowOptionDailogEvent());
        //     },
        //     child: const Text("Play in Room")),
      ],
    ));
  }
}
