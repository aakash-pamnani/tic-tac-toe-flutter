import 'package:flutter/material.dart';
import 'package:tic_tac_toe/extensions/extensions.dart';

class JoinGameDailog extends StatelessWidget {
  const JoinGameDailog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Enter Joining Code...",
        style: const TextStyle().mediumSize,
      ),
      content: const TextField(
        maxLines: 1,
        maxLength: 4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: "Enter the Code to join", hintMaxLines: 1),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(onPressed: () {}, child: const Text("Ok"))
      ],
    );
  }
}
