import 'package:flutter/material.dart';

class ScreenSize extends ChangeNotifier {
  double _screenWidth = 0;
  double _screenHeight = 0;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  set screenWidth(double width) {
    _screenWidth = width;
    notifyListeners();
  }

  set screenHeight(double height) {
    _screenHeight = height;
    notifyListeners();
  }
}

class UserProfile extends ChangeNotifier {
  String _personName = '';
  String _personEmail = '';

  String get personName => _personName;

  String get personEmail => _personEmail;

  set personName(String name) {
    _personName = name;
    notifyListeners();
  }

  set personEmail(String email) {
    _personEmail = email;
    notifyListeners();
  }
}
