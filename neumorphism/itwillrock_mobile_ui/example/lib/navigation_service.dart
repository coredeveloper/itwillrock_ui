import 'package:flutter/material.dart';

class NavigationService with ChangeNotifier {
  Widget _currentWidget;

  NavigationService(this._currentWidget);

  Widget get currentWidget => _currentWidget;

  void navigateTo(Widget widget) {
    _currentWidget = widget;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
