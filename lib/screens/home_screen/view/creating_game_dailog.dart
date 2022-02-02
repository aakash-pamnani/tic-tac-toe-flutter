import 'package:flutter/material.dart';
import 'package:tic_tac_toe/extensions/extensions.dart';

class CreatingGameDailog extends StatelessWidget {
  const CreatingGameDailog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Creating new Game",
        style: const TextStyle().mediumSize,
      ),
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 20,
          ),
          Text("Please Wait...")
        ],
      ),
    );
  }
}
