// import 'dart:ffi';
// import 'dart:js';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:make_a_word/PlayingGrid.dart';
// import 'package:make_a_word/startScreen.dart';
// import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
// import 'constants.dart';
// import 'dart:math';
// import 'package:list_english_words/list_english_words.dart';
// import 'flipping_card.dart';
// import 'keyboard.dart';
// import 'dart:html';
// import 'package:make_a_word/LoadingScreen.dart';
// import 'package:flutter/scheduler.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:make_a_word/PlayerWordList.dart';
import 'package:make_a_word/WelcomePage.dart';
import 'package:make_a_word/eng_word_list.dart';
import 'package:make_a_word/leaderboard.dart';
import 'package:make_a_word/my_flutter_app_icons.dart';
import 'package:provider/provider.dart';
import 'models/cell.dart';
import 'models/scores.dart';
import 'PlayingGrid.dart';
import 'firebase_options.dart';
// import 'package:collection/collection.dart';
// import '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext ctx) => Single_cell()),
      ChangeNotifierProvider(create: (BuildContext ctx) => scores())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomePage(),
    );
  }
}

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  int no_of_players = 5;
  Homepage({super.key, required this.no_of_players});

  List<int> highlighted = [];
  Map<int, String?> mp = {};
  Set<String> words = {};
  // PriorityQueue? max_score = PriorityQueue<List<dynamic>>();

  // final Color _primaryColor = const Color.fromARGB(255, 202, 202, 202);
  // final Color _selectedColor = const Color.fromARGB(255, 255, 255, 0);

  Padding custKey(String char, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () async {
          if (highlighted.isEmpty) {
            ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                margin: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: MediaQuery.of(ctx).size.width * 0.20,
                ),
                elevation: 5.0,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 1000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                content: const Wrap(
                  children: [
                    Center(
                      child: Text(
                        'Please select a cell',
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (mp.containsKey(highlighted[0])) {
            ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                margin: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: MediaQuery.of(ctx).size.width * 0.20,
                ),
                elevation: 5.0,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 1000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                content: const Wrap(
                  children: [
                    Center(
                      child: Text(
                        'Please select a cell',
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            mp[highlighted[0]] = char;
            Provider.of<Single_cell>(ctx, listen: false).changeSelected(
                !Provider.of<Single_cell>(ctx, listen: false).selected);
            // Provider.of<scores>(ctx,listen: false).inc_player1(4);

//**********************************words identify logic************************* */

            int temp = highlighted[0];
            // int temp3 = temp2;
            String? word = "";
            List<String> start = [];
            List<String> end = [];
            // while (temp <= 99) {
            //   if (mp.containsKey(temp)) {
            //     word = word! + mp[temp]!;
            //   } else
            //     break;
            //   words.add(word);
            //   temp += 11;
            // }

            //***************************diagonal elements********************** */

            while (mp.containsKey(temp)) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }
              end.add(word.split('').reversed.join());
              words.add(word.split('').reversed.join());
              temp -= 11;
            }

            temp = highlighted[0];
            word = "";

            while (mp.containsKey(temp)) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }

              start.add(word);
              words.add(word);
              temp += 11;
            }

            for (var i in end) {
              for (var j in start) {
                words.add(i + j.substring(1));
              }
            }
            // temp += 11;
            // while (temp <= 99) {
            //   if (mp.containsKey(temp)) {
            //     word = word! + mp[temp]!;
            //   } else {
            //     break;
            //   }
            //   words.add(word);
            //   temp += 11;
            // }

            //***************************horizontal elements********************** */
            temp = highlighted[0];
            word = "";
            start.clear();
            end.clear();

            while (mp.containsKey(temp) && temp >= (10 * ((temp / 10)))) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }
              end.add(word.split('').reversed.join());
              words.add(word.split('').reversed.join());
              temp -= 1;
            }

            temp = highlighted[0];
            word = "";

            while (mp.containsKey(temp)) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }
              start.add(word);
              words.add(word);
              temp += 1;
            }

            for (var i in end) {
              for (var j in start) {
                words.add(i + j.substring(1));
              }
            }
            // temp += 1;

            // while (temp <= 10 * ((temp / 10) + 1)) {
            //   if (mp.containsKey(temp)) {
            //     word = word! + mp[temp]!;
            //   } else {
            //     break;
            //   }
            //   words.add(word);
            //   temp += 1;
            // }
            //***************************vertical elements********************** */

            temp = highlighted[0];
            word = "";
            start.clear();
            end.clear();

            while (mp.containsKey(temp) && temp > temp % 10) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }
              end.add(word.split('').reversed.join());
              words.add(word.split('').reversed.join());
              temp -= 10;
            }

            temp = highlighted[0];
            word = "";

            while (mp.containsKey(temp)) {
              if (mp.containsKey(temp)) {
                word = word! + mp[temp]!;
              } else {
                break;
              }
              start.add(word);
              words.add(word);
              temp += 10;
            }

            for (var i in end) {
              for (var j in start) {
                words.add(i + j.substring(1));
              }
            }

            // temp += 10;

            // while (temp <= (80 + (temp % 10))) {
            //   if (mp.containsKey(temp)) {
            //     word = word! + mp[temp]!;
            //   } else {
            //     break;
            //   }
            //   words.add(word);
            //   temp += 10;
            // }

            // print(temp2);

            // print(mp);
            // logger.d(words);
            List<String> finalwords = words.toList();
            finalwords.sort((a, b) => a.length.compareTo(b.length));
            // print(finalwords);
            // var response;
            for (int w = finalwords.length - 1; w >= 0; w--) {
              // String url = 'http://10.0.2.2:5000/api?Query=${finalwords[w]}';
              // String url =
              //     "http://ec2-51-20-37-226.eu-north-1.compute.amazonaws.com:8080/api?Query=${finalwords[w]}";
              // response = await http.get(Uri.parse(url)).then((value) {
              //   words.clear();
              // });

              // var jsonResponse =
              //     convert.jsonDecode(response.body) as Map<String, dynamic>;
              // print(jsonResponse);
              var jsonResponse = eng_word_list.contains(finalwords[w]);

              if (jsonResponse) {
                // logger.e(finalwords[w]);
                // print(finalwords[w]);

                ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: MediaQuery.of(ctx).size.width * 0.35,
                    ),
                    elevation: 5.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    content: Wrap(
                      children: [
                        Center(
                          child: Text(
                            finalwords[w],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                if ((Provider.of<scores>(ctx, listen: false).chance) == 0) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player1(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p1_word(finalwords[w]);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    1) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player2(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p2_word(finalwords[w]);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    2) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player3(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p3_word(finalwords[w]);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    3) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player4(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p4_word(finalwords[w]);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    4) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player5(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p5_word(finalwords[w]);
                }
                Provider.of<scores>(ctx, listen: false)
                    .inc_chance(no_of_players);
                words.clear();
                Provider.of<scores>(ctx, listen: false).updateMaxScore();
                break;
              }

//*****************************Checking reversed words********************************* */

              jsonResponse = eng_word_list
                  .contains(finalwords[w].split('').reversed.join());
              if (jsonResponse) {
                // logger.e(finalwords[w]);
                // print(finalwords[w].split('').reversed.join());

                ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: MediaQuery.of(ctx).size.width * 0.35,
                    ),
                    elevation: 5.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    content: Wrap(
                      children: [
                        Center(
                          child: Text(
                            finalwords[w].split('').reversed.join(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                if ((Provider.of<scores>(ctx, listen: false).chance) == 0) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player1(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p1_word(finalwords[w].split('').reversed.join());
                  // Provider.of<scores>(ctx).updateMaxScore(finalwords[w].length);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    1) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player2(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p2_word(finalwords[w].split('').reversed.join());
                  // Provider.of<scores>(ctx).updateMaxScore(finalwords[w].length);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    2) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player3(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p3_word(finalwords[w].split('').reversed.join());
                  // Provider.of<scores>(ctx).updateMaxScore(finalwords[w].length);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    3) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player4(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p4_word(finalwords[w].split('').reversed.join());
                  // Provider.of<scores>(ctx).updateMaxScore(finalwords[w].length);
                } else if ((Provider.of<scores>(ctx, listen: false).chance) ==
                    4) {
                  Provider.of<scores>(ctx, listen: false)
                      .inc_player5(finalwords[w].length);
                  Provider.of<scores>(ctx, listen: false)
                      .add_p5_word(finalwords[w].split('').reversed.join());
                  // Provider.of<scores>(ctx).updateMaxScore(finalwords[w].length);
                }
                Provider.of<scores>(ctx, listen: false)
                    .inc_chance(no_of_players);
                words.clear();
                Provider.of<scores>(ctx, listen: false).updateMaxScore();

                break;
              }
              words.clear();
            }
          }
          if (mp.length == 100) {
            Provider.of<scores>(ctx, listen: false).GameOver(true);
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 5, color: const Color.fromARGB(255, 223, 167, 0)),
              color: const Color.fromARGB(255, 255, 200, 33),
            ),
            height: MediaQuery.of(ctx).size.width * 0.09,
            width: MediaQuery.of(ctx).size.width * 0.09,
            child: Center(
                child: Text(
              char,
              style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 114, 86, 0)),
            )),
          ),
        ),
      ),
    );
  }

  // Column custKeyboard() {
  //   return Column(
  //     // mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           custKey('q'),
  //           custKey('w'),
  //           custKey('e'),
  //           custKey('r'),
  //           custKey('t'),
  //           custKey('y'),
  //           custKey('u'),
  //           custKey('i'),
  //           custKey('o'),
  //           custKey('p'),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           custKey('a', context),
  //           custKey('s'),
  //           custKey('d'),
  //           custKey('f'),
  //           custKey('g'),
  //           custKey('h'),
  //           custKey('j'),
  //           custKey('k'),
  //           custKey('l'),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           custKey('z'),
  //           custKey('x'),
  //           custKey('c'),
  //           custKey('v'),
  //           custKey('b'),
  //           custKey('n'),
  //           custKey('m'),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Column custKeyboard() {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              custKey('q', context),
              custKey('w', context),
              custKey('e', context),
              custKey('r', context),
              custKey('t', context),
              custKey('y', context),
              custKey('u', context),
              custKey('i', context),
              custKey('o', context),
              custKey('p', context),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              custKey('a', context),
              custKey('s', context),
              custKey('d', context),
              custKey('f', context),
              custKey('g', context),
              custKey('h', context),
              custKey('j', context),
              custKey('k', context),
              custKey('l', context),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              custKey('z', context),
              custKey('x', context),
              custKey('c', context),
              custKey('v', context),
              custKey('b', context),
              custKey('n', context),
              custKey('m', context),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Home",
          onPressed: () {
            mp.clear();
            highlighted.clear();
            Provider.of<scores>(context, listen: false).reset_player1();
            Provider.of<scores>(context, listen: false).reset_player2();
            Provider.of<scores>(context, listen: false).reset_player3();
            Provider.of<scores>(context, listen: false).reset_player4();
            Provider.of<scores>(context, listen: false).reset_player5();
            Provider.of<scores>(context, listen: false).reset_p1_word();
            Provider.of<scores>(context, listen: false).reset_p2_word();
            Provider.of<scores>(context, listen: false).reset_p3_word();
            Provider.of<scores>(context, listen: false).reset_p4_word();
            Provider.of<scores>(context, listen: false).reset_p5_word();
            Provider.of<scores>(context, listen: false).reset_chance();
            Provider.of<scores>(context, listen: false).GameOver(false);
            Provider.of<scores>(context, listen: false).resetMaxScore();
            Provider.of<Single_cell>(context, listen: false)
                .changeSelected(false);
            Get.off(() {
              return WelcomePage();
            });
            Provider.of<scores>(context, listen: false).GameOver(false);
          },
          icon: const Icon(Icons.home_outlined),
        ),
        // backgroundColor: Color.fromARGB(255, 141, 255, 169),
        actions: [
          IconButton(
              tooltip: "LeaderBoard",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LeaderboardScreen()));
              },
              icon: const Icon(Icons.leaderboard)),
          IconButton(
              tooltip: "Finish Game",
              onPressed: () {
                Provider.of<scores>(context, listen: false).GameOver(true);
                if (Provider.of<scores>(context, listen: false).player1 ==
                    Provider.of<scores>(context, listen: false).max_score) {
                  FirebaseFirestore.instance
                      .collection("TopScorers")
                      .doc(Provider.of<scores>(context, listen: false).p1_name)
                      .set({
                    'name': Provider.of<scores>(context, listen: false).p1_name,
                    'score':
                        Provider.of<scores>(context, listen: false).max_score
                  });
                }

                if (Provider.of<scores>(context, listen: false).player2 ==
                    Provider.of<scores>(context, listen: false).max_score) {
                  FirebaseFirestore.instance
                      .collection("TopScorers")
                      .doc(Provider.of<scores>(context, listen: false).p2_name)
                      .set({
                    'name': Provider.of<scores>(context, listen: false).p2_name,
                    'score':
                        Provider.of<scores>(context, listen: false).max_score
                  });
                }
                if (Provider.of<scores>(context, listen: false).player3 ==
                    Provider.of<scores>(context, listen: false).max_score) {
                  FirebaseFirestore.instance
                      .collection("TopScorers")
                      .doc(Provider.of<scores>(context, listen: false).p3_name)
                      .set({
                    'name': Provider.of<scores>(context, listen: false).p3_name,
                    'score':
                        Provider.of<scores>(context, listen: false).max_score
                  });
                }
                if (Provider.of<scores>(context, listen: false).player4 ==
                    Provider.of<scores>(context, listen: false).max_score) {
                  FirebaseFirestore.instance
                      .collection("TopScorers")
                      .doc(Provider.of<scores>(context, listen: false).p4_name)
                      .set({
                    'name': Provider.of<scores>(context, listen: false).p4_name,
                    'score':
                        Provider.of<scores>(context, listen: false).max_score
                  });
                }
                if (Provider.of<scores>(context, listen: false).player5 ==
                    Provider.of<scores>(context, listen: false).max_score) {
                  FirebaseFirestore.instance
                      .collection("TopScorers")
                      .doc(Provider.of<scores>(context, listen: false).p5_name)
                      .set({
                    'name': Provider.of<scores>(context, listen: false).p5_name,
                    'score':
                        Provider.of<scores>(context, listen: false).max_score
                  });
                }
              },
              icon: const Icon(Icons.check)),
          IconButton(
            tooltip: "Restart",
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              mp.clear();
              highlighted.clear();
              Provider.of<scores>(context, listen: false).reset_player1();
              Provider.of<scores>(context, listen: false).reset_player2();
              Provider.of<scores>(context, listen: false).reset_player3();
              Provider.of<scores>(context, listen: false).reset_player4();
              Provider.of<scores>(context, listen: false).reset_player5();
              Provider.of<scores>(context, listen: false).reset_p1_word();
              Provider.of<scores>(context, listen: false).reset_p2_word();
              Provider.of<scores>(context, listen: false).reset_p3_word();
              Provider.of<scores>(context, listen: false).reset_p4_word();
              Provider.of<scores>(context, listen: false).reset_p5_word();
              Provider.of<scores>(context, listen: false).reset_chance();
              Provider.of<scores>(context, listen: false).GameOver(false);
              Provider.of<scores>(context, listen: false).resetMaxScore();
              Provider.of<Single_cell>(context, listen: false)
                  .changeSelected(false);
            },
          ),
        ],
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
      body: Stack(
        children: [
          Consumer<Single_cell>(
            builder: (_, child, __) => SingleChildScrollView(
              child: Column(
                children: [
                  PlayingGrid(highlighted: highlighted, mp: mp),
                  Container(
                    color: Colors.white,
                    child: custKeyboard(),
                  ),
                  Visibility(
                    visible: no_of_players > 0,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0),
                        tooltip: "Rename",
                        onPressed: () {
                          commonNameChange(context, 0);
                        },
                        icon: const Icon(MyFlutterApp.pencil),
                      ),
                      // subtitle: Provider.of<scores>(context,listen: false).chance==0?Text("Your Turn"):Text(""),
                      title: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PlayerWordList(
                                    player_word_list:
                                        Provider.of<scores>(context)
                                            .p1_words))),
                        child: Provider.of<scores>(context).chance != 0
                            ? Text(
                                Provider.of<scores>(context).p1_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            : Text(
                                "${Provider.of<scores>(context).p1_name} <",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                      ),
                      trailing: Text(
                          Provider.of<scores>(context).player1.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players > 1,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0),
                        tooltip: "Rename",
                        onPressed: () {
                          commonNameChange(context, 1);
                        },
                        icon: const Icon(MyFlutterApp.pencil),
                      ),
                      // subtitle: Provider.of<scores>(context,listen: false).chance==1?Text("Your Turn"):Text(""),
                      title: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PlayerWordList(
                                    player_word_list:
                                        Provider.of<scores>(context)
                                            .p2_words))),
                        child: Provider.of<scores>(context, listen: false)
                                    .chance ==
                                1
                            ? Text(
                                "${Provider.of<scores>(context).p2_name} <",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            : Text(
                                Provider.of<scores>(context).p2_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                      ),
                      trailing: Text(
                          Provider.of<scores>(context).player2.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players > 2,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0),
                        tooltip: "Rename",
                        onPressed: () {
                          commonNameChange(context, 2);
                        },
                        icon: const Icon(MyFlutterApp.pencil),
                      ),
                      // subtitle: Provider.of<scores>(context,listen: false).chance==2?Text("Your Turn"):Text(""),
                      title: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PlayerWordList(
                                    player_word_list:
                                        Provider.of<scores>(context)
                                            .p3_words))),
                        child: Provider.of<scores>(context, listen: false)
                                    .chance ==
                                2
                            ? Text(
                                "${Provider.of<scores>(context).p3_name} <",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            : Text(
                                Provider.of<scores>(context).p3_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                      ),
                      trailing: Text(
                          Provider.of<scores>(context).player3.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players > 3,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0),
                        tooltip: "Rename",
                        onPressed: () {
                          commonNameChange(context, 3);
                        },
                        icon: const Icon(MyFlutterApp.pencil),
                      ),
                      // subtitle: Provider.of<scores>(context,listen: false).chance==3?Text("Your Turn"):Text(""),
                      title: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PlayerWordList(
                                    player_word_list:
                                        Provider.of<scores>(context)
                                            .p4_words))),
                        child: Provider.of<scores>(context, listen: false)
                                    .chance ==
                                3
                            ? Text(
                                "${Provider.of<scores>(context).p4_name} <",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            : Text(
                                Provider.of<scores>(context).p4_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                      ),
                      trailing: Text(
                          Provider.of<scores>(context).player4.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players > 4,
                    child: ListTile(
                      leading: IconButton(
                        padding: const EdgeInsets.all(0),
                        tooltip: "Rename",
                        onPressed: () {
                          commonNameChange(context, 4);
                        },
                        icon: const Icon(MyFlutterApp.pencil),
                      ),
                      // subtitle: Provider.of<scores>(context,listen: false).chance==4?Text("Your Turn"):Text(""),
                      title: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PlayerWordList(
                                    player_word_list:
                                        Provider.of<scores>(context)
                                            .p5_words))),
                        child: Provider.of<scores>(context, listen: false)
                                    .chance ==
                                4
                            ? Text(
                                "${Provider.of<scores>(context).p5_name} <",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              )
                            : Text(
                                Provider.of<scores>(context).p5_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                      ),
                      trailing: Text(
                          Provider.of<scores>(context).player5.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: Provider.of<scores>(context).gameOver,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color.fromARGB(179, 255, 255, 255),
              )),
          Visibility(
              visible: Provider.of<scores>(context).gameOver,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/Winner.json", reverse: true),
                  Visibility(
                    visible: Provider.of<scores>(context).player1 ==
                        Provider.of<scores>(context).max_score,
                    child: Text(
                      "${Provider.of<scores>(context).p1_name} won",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: Provider.of<scores>(context).player2 ==
                        Provider.of<scores>(context).max_score,
                    child: Text(
                      "${Provider.of<scores>(context).p2_name} won",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players >= 3 &&
                        Provider.of<scores>(context).player3 ==
                            Provider.of<scores>(context).max_score,
                    child: Text(
                      "${Provider.of<scores>(context).p3_name} won",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players >= 4 &&
                        Provider.of<scores>(context).player4 ==
                            Provider.of<scores>(context).max_score,
                    child: Text(
                      "${Provider.of<scores>(context).p4_name} won",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: no_of_players >= 5 &&
                        Provider.of<scores>(context).player5 ==
                            Provider.of<scores>(context).max_score,
                    child: Text(
                      "${Provider.of<scores>(context).p5_name} won",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.replay_outlined),
                    onPressed: () {
                      mp.clear();
                      highlighted.clear();
                      Provider.of<scores>(context, listen: false)
                          .reset_player1();
                      Provider.of<scores>(context, listen: false)
                          .reset_player2();
                      Provider.of<scores>(context, listen: false)
                          .reset_player3();
                      Provider.of<scores>(context, listen: false)
                          .reset_player4();
                      Provider.of<scores>(context, listen: false)
                          .reset_player5();
                      Provider.of<scores>(context, listen: false)
                          .reset_p1_word();
                      Provider.of<scores>(context, listen: false)
                          .reset_p2_word();
                      Provider.of<scores>(context, listen: false)
                          .reset_p3_word();
                      Provider.of<scores>(context, listen: false)
                          .reset_p4_word();
                      Provider.of<scores>(context, listen: false)
                          .reset_p5_word();
                      Provider.of<scores>(context, listen: false)
                          .reset_chance();
                      Provider.of<scores>(context, listen: false)
                          .resetMaxScore();
                      Provider.of<Single_cell>(context, listen: false)
                          .changeSelected(false);
                      Provider.of<scores>(context, listen: false)
                          .GameOver(false);
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => LeaderboardScreen()));
                      },
                      icon: const Icon(Icons.leaderboard)),
                ],
              ))),
        ],
      ),
    );
  }

  Future<dynamic> commonNameChange(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename'),
          content: SingleChildScrollView(
            child: TextFormField(
              onChanged: (text) {
                for (int i = 0; i < text.length; i++) {
                  if ((text.codeUnitAt(i) >= 65 && text.codeUnitAt(i) < 82) ||
                      (text.codeUnitAt(i) >= 97 && text.codeUnitAt(i) < 124)) {
                    Provider.of<scores>(context, listen: false)
                        .p_change(text, index);
                  }
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup card.
              },
            ),
          ],
        ); // Display the popup card.
      },
    );
  }
}
