import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tic_tac_toe/extensions/extensions.dart';
import 'package:tic_tac_toe/screens/home_screen/bloc/home_screen_bloc/homescreen_bloc.dart';

class OptionDailog extends StatelessWidget {
  const OptionDailog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          "Select an option...",
          style: const TextStyle().mediumSize,
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(
                        MediaQuery.of(context).size.width * 0.8))),
                onPressed: () {
                  BlocProvider.of<HomeScreenBloc>(context)
                      .add(ShowJoinGameDailogEvent());
                  Navigator.pop(context);
                },
                child: const Text("Join Game"),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8))),
                  onPressed: () {
                    BlocProvider.of<HomeScreenBloc>(context)
                        .add(ShowCreatingGameDailogEvent());
                    Navigator.pop(context);
                  },
                  child: const Text("Create Game"))
            ],
          ),
        ));
  }
}
