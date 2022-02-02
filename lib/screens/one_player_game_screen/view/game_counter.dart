import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/screens/one_player_game_screen/bloc/one_player_bloc.dart';



class GameCounter extends StatelessWidget {
  const GameCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnePlayerBloc, OnePlayerState>(
      //the win counter will only change when game is starting or game is over
      /// therefore only build this widget when state is [GameInitilize] or GameOver
      buildWhen: (previous, current) {
        return current is OnePlayerGameOver || current is OnePlayerInitialState;
      },
      builder: (context, state) {
        int xWins = 0;
        int oWins = 0;
        int draw = 0;
        if (state is OnePlayerInitialState) {
          xWins = state.xWin;
          oWins = state.oWin;
          draw = state.draw;
        } else if (state is OnePlayerGameOver) {
          xWins = state.xWins;
          oWins = state.oWins;
          draw = state.draws;
        }
        if (state is OnePlayerInitialState || state is OnePlayerGameOver) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/x.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${xWins.toString()} Wins"),
                  ],
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/o.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${oWins.toString()} Wins"),
                  ],
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/draw.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${draw.toString()} Draw"),
                  ],
                ),
              ))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
