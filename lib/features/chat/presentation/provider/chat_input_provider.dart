import 'package:flutter/material.dart';
import '../../data/model/chat_reply.dart';

class ChatInputProvider with ChangeNotifier {
  String _inputTexts = "";
  String get inputTexts => _inputTexts;

  ChatReply? _reply;
  ChatReply? get reply => _reply;

  void userTypes(String text) {
    _inputTexts = text;
    notifyListeners();
  }

  void sentText() {
    _inputTexts = "";
    notifyListeners();
  }

  void replyMessage(ChatReply reply) {
    _reply = reply;
    notifyListeners();
  }

  void clearReply() {
    _reply = null;
    notifyListeners();
  }
}
