import 'dart:developer';

import 'package:flutter/material.dart';

class ReplyTextFieldProvider with ChangeNotifier {
  bool _showReplyTextField = false;
  bool get showReplyTextField => _showReplyTextField;

  void toggleReplyTextField() {
    _showReplyTextField = !_showReplyTextField;
    log("SHOW : $_showReplyTextField");
    notifyListeners();
  }
}
