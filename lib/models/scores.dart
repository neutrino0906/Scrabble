// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

// import '../constants.dart';

class scores extends ChangeNotifier {
  int player1 = 0;
  int player2 = 0;
  int player3 = 0;
  int player4 = 0;
  int player5 = 0;
  String p1_name = "Player1";
  String p2_name = "Player2";
  String p3_name = "Player3";
  String p4_name = "Player4";
  String p5_name = "Player5";

  bool gameOver = false;

  List<String> p1_words = [];
  List<String> p2_words = [];
  List<String> p3_words = [];
  List<String> p4_words = [];
  List<String> p5_words = [];

  int chance = 0;

  int max_score = 0;

  void inc_player1(int score) {
    player1 += score;
    notifyListeners();
  }

  void reset_player1() {
    player1 = 0;
    notifyListeners();
  }

  void inc_player2(int score) {
    player2 += score;
    notifyListeners();
  }

  void reset_player2() {
    player2 = 0;
    notifyListeners();
  }

  void inc_player3(int score) {
    player3 += score;
    notifyListeners();
  }

  void reset_player3() {
    player3 = 0;
    notifyListeners();
  }

  void inc_player4(int score) {
    player4 += score;
    notifyListeners();
  }

  void reset_player4() {
    player4 = 0;
    notifyListeners();
  }

  void inc_player5(int score) {
    player5 += score;
    notifyListeners();
  }

  void reset_player5() {
    player5 = 0;
    notifyListeners();
  }

  void inc_chance(int val) {
    chance++;
    chance %= val;
  }

  void reset_chance() {
    chance = 0;
    notifyListeners();
  }

  void p_change(String name, int player) {
    // logger.d(player);
    switch (player) {
      case 0:
        {
          p1_name = name;
          notifyListeners();
        }
        break;
      case 1:
        {
          p2_name = name;
          notifyListeners();
        }
        break;
      case 2:
        {
          p3_name = name;
          notifyListeners();
        }
        break;
      case 3:
        {
          p4_name = name;
          notifyListeners();
        }
        break;
      case 4:
        {
          p5_name = name;
          notifyListeners();
        }
        break;
    }
    notifyListeners();
  }

  void add_p1_word(String word) => p1_words.add(word);
  void add_p2_word(String word) => p2_words.add(word);
  void add_p3_word(String word) => p3_words.add(word);
  void add_p4_word(String word) => p4_words.add(word);
  void add_p5_word(String word) => p5_words.add(word);

  void reset_p1_word() => p1_words.clear();
  void reset_p2_word() => p2_words.clear();
  void reset_p3_word() => p3_words.clear();
  void reset_p4_word() => p4_words.clear();
  void reset_p5_word() => p5_words.clear();

  void GameOver(bool value) {
    gameOver = value;
    notifyListeners();
  }

  void updateMaxScore() {
    max_score = max(max_score,
        max(player1, max(player2, max(player3, max(player4, player5)))));
    // notifyListeners();
  }

  void resetMaxScore() {
    max_score = 0;
  }

  // int get_player1()=>player1;
  // int get_player2()=>player2;
}
