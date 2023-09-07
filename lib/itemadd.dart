import 'package:flutter/material.dart';
import 'package:notes/main.dart';

class Itemadd extends StatelessWidget {
  const Itemadd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return const MyHomePage(title: "");
                  },
                ),
              );
            },
            child: const Text('back')));
  }
}
