import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:make_a_word/LoadingScreen.dart';
import 'package:make_a_word/leaderboard.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int no_of_players = 2;

    List<String> list = ['2', '3', '4', '5'];
  String dropdownValue = '2';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset("assets/SpaceRocket.json"),
          Flexible(
              child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 237, 237),
              // border: Border.all(width: 10, color: Color.fromARGB(255, 212, 212, 212),)
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.off(
                              () => LoadingScreen(
                                    no_of_players: int.parse(dropdownValue),
                                  ),
                              transition: Transition.circularReveal,
                              duration: Duration(seconds: 3));
                        },
                        child: const Text(
                          "PLAY",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        )),
                    DropdownButton<String>(
    value: dropdownValue.toString(),
    icon: const Icon(Icons.arrow_drop_down),
    elevation: 16,
    style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String? value) {
      // This is called when the user selects an item.
      setState(() {
        dropdownValue = value!;
      });
    },
    items: list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  ),
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "RULES",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => LeaderboardScreen()));
                    },
                    child: const Text(
                      "LEADERBOARD",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

