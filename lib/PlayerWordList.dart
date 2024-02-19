// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PlayerWordList extends StatelessWidget {
  // PlayerWordList({super.key});

  List<String> player_word_list = [];

  PlayerWordList({super.key, required this.player_word_list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 141, 255, 169),
        title: const Text(
          'Scrabble',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Color.fromARGB(255, 172, 255, 183),
                  Color.fromARGB(255, 33, 243, 121)
                ]),
          ),
        ),
      ),
      body: player_word_list.isEmpty? const Center(child: Text("No Words Created", style: TextStyle(fontSize: 25),)):ListView.builder(
        itemBuilder: (ctx, i) {
          if (player_word_list[i].length > 1) {
            return ListTile(
              title: Text(player_word_list[i]),
              leading: const Icon(Icons.arrow_forward_ios),
            );
          } else {
            return const SizedBox();
          }
        },
        itemCount: player_word_list.length,
      ),
    );
  }
}
