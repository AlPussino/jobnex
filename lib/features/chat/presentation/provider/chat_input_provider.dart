import 'package:flutter/material.dart';

class ChatInputProvider with ChangeNotifier {
  String _inputTexts = "";
  String get inputTexts => _inputTexts;

  void userTypes(String text) {
    _inputTexts = text;
    notifyListeners();
  }

  void sentText() {
    _inputTexts = "";
    notifyListeners();
  }
}
