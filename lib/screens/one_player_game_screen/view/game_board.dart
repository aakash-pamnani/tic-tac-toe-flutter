import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/screens/one_player_game_screen/bloc/one_player_bloc.dart';




import 'tile.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnePlayerBloc, OnePlayerState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Tile(
                        x: 0,
                        y: 0,
                        value: state.data[0][0],
                      ),
                      Tile(
                        x: 0,
                        y: 1,
                        value: state.data[0][1],
                      ),
                      Tile(
                        x: 0,
                        y: 2,
                        value: state.data[0][2],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Tile(
                        x: 1,
                        y: 0,
                        value: state.data[1][0],
                      ),
                      Tile(
                        x: 1,
                        y: 1,
                        value: state.data[1][1],
                      ),
                      Tile(
                        x: 1,
                        y: 2,
                        value: state.data[1][2],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Tile(
                        x: 2,
                        y: 0,
                        value: state.data[2][0],
                      ),
                      Tile(
                        x: 2,
                        y: 1,
                        value: state.data[2][1],
                      ),
                      Tile(
                        x: 2,
                        y: 2,
                        value: state.data[2][2],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
