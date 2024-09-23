import 'dart:developer';

import 'package:flutter/material.dart';

class ReplyTextFieldProvider with ChangeNotifier {
  String _comment_id = '';
  String get comment_id => _comment_id;

  void replyToComment(String commentId) {
    _comment_id = commentId;
    log("Assigned Comment Id : $_comment_id");
    notifyListeners();
  }

  void clearCommentId() {
    _comment_id = '';
    log("Comment Id cleared");
    notifyListeners();
  }
}
