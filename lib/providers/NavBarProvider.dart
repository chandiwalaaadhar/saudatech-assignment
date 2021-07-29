import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  var selectedPage = 1;

  void setPage(int pg) {
    selectedPage = pg;
    notifyListeners();
  }

  get page {
    return selectedPage;
  }
}
