import 'package:flutter/foundation.dart';

class SignUpPageProvider with ChangeNotifier {
  String currentGender = "Male";
  void changeGender(String gender) {
    currentGender = gender;
    notifyListeners();
  }
}
