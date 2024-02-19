import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// ignore: must_be_immutable, camel_case_types
class Single_cell extends ChangeNotifier {
  bool color = false;
  bool selected = false;

  void changeColor(bool val) {
    color = val;
    notifyListeners();
  }

  void changeSelected(bool val) {
    color = val;
    notifyListeners();
  }
}
