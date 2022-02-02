import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/screens/one_player_game_screen/bloc/one_player_bloc.dart';



/// A single [Tile] that represent O , X or empty

class Tile extends StatelessWidget {
  const Tile({required this.x, required this.y, required this.value, Key? key})
      : super(key: key);

  final int x, y; // 2D position on 3x3 matrix.

  final String value; // The of the tile O or X or empty.

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Add TileTap event on click of tile.
          BlocProvider.of<OnePlayerBloc>(context).add(TileTapByPlayer(x, y));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            //Get border of the container based on the postion in the matrix.
            border: getBorder(x, y),
          ),
          child: getChild(value), //get x, o or empty based on value.
        ),
      ),
    );
  }

  BoxBorder getBorder(int x, int y) {
    var side = const BorderSide(
      color: Colors.grey,
      width: 2.0,
    );
    if (x == 0 && y == 0) {
      return Border(right: side, bottom: side);
    } else if (x == 0 && y == 1) {
      return Border(right: side, bottom: side, left: side);
    } else if (x == 0 && y == 2) {
      return Border(left: side, bottom: side);
    } else if (x == 1 && y == 0) {
      return Border(right: side, bottom: side, top: side);
    } else if (x == 1 && y == 1) {
      return Border(top: side, right: side, bottom: side, left: side);
    } else if (x == 1 && y == 2) {
      return Border(top: side, left: side, bottom: side);
    } else if (x == 2 && y == 0) {
      return Border(
        right: side,
        top: side,
      );
    } else if (x == 2 && y == 1) {
      return Border(right: side, top: side, left: side);
    } else if (x == 2 && y == 2) {}
    return Border(left: side, top: side);
  }

  Widget? getChild(String value) {
    if (value == "o") {
      //If value of child is O return Image of O.
      return Image.asset(
        "assets/images/o.png",
        scale: 1.0,
      );
    } else if (value == "x") {
      //If value of child is X return Image of X.
      return Image.asset(
        "assets/images/x.png",
      );
    } else {
      //If value of child is "" return null.
      return null;
    }
  }
}
