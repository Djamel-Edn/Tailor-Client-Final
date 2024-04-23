import 'package:flutter/material.dart';

class PageCurrent extends ChangeNotifier {
  int _pagecurrent = 0;
  int get pagecurrent => _pagecurrent;
  set pagecurrent(int newpage) {
    _pagecurrent = newpage;
    notifyListeners();
  }
}
