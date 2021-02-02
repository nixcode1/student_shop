import 'package:flutter/material.dart';

class CustomDrawerController extends ChangeNotifier {

  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  void openDrawer(Size size) {
    xOffset = size.width * 0.6;
    yOffset = size.height * 0.1;
    scaleFactor = 0.8;
    isDrawerOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1.0;
    isDrawerOpen = false;
    notifyListeners();
  }
}
