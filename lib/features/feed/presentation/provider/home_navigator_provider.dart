import 'package:flutter/foundation.dart';

class HomeNavigatorProvider with ChangeNotifier {
  int currentpageIndex = 0;
  void changePage(int pageIndex) {
    currentpageIndex = pageIndex;
    notifyListeners();
  }
}
