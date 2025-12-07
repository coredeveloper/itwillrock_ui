import 'package:flutter/material.dart';

/// Navigation service that supports nested navigation with a stack.
///
/// Tracks navigation depth for displaying nested back buttons.
class NavigationService with ChangeNotifier {
  final List<Widget> _navigationStack = [];
  final List<String> _titleStack = [];

  NavigationService(Widget initialWidget, [String initialTitle = '']) {
    _navigationStack.add(initialWidget);
    _titleStack.add(initialTitle);
  }

  /// Current widget being displayed
  Widget get currentWidget =>
      _navigationStack.isNotEmpty ? _navigationStack.last : const SizedBox();

  /// Current screen title
  String get currentTitle =>
      _titleStack.isNotEmpty ? _titleStack.last : '';

  /// Current nesting level (1 = root, 2 = one level deep, etc.)
  int get nestingLevel => _navigationStack.length;

  /// Whether we can go back
  bool get canGoBack => _navigationStack.length > 1;

  /// Navigate to a new screen (pushes onto stack)
  void navigateTo(Widget widget, [String title = '']) {
    _navigationStack.add(widget);
    _titleStack.add(title);
    _notify();
  }

  /// Replace current screen (doesn't add to stack)
  void replaceCurrent(Widget widget, [String title = '']) {
    if (_navigationStack.isNotEmpty) {
      _navigationStack.removeLast();
      _titleStack.removeLast();
    }
    _navigationStack.add(widget);
    _titleStack.add(title);
    _notify();
  }

  /// Go back to previous screen
  void pop() {
    if (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      _titleStack.removeLast();
      notifyListeners();
    }
  }

  /// Go back to root screen
  void popToRoot() {
    while (_navigationStack.length > 1) {
      _navigationStack.removeLast();
      _titleStack.removeLast();
    }
    _notify();
  }

  /// Reset to a new root screen
  void resetTo(Widget widget, [String title = '']) {
    _navigationStack.clear();
    _titleStack.clear();
    _navigationStack.add(widget);
    _titleStack.add(title);
    _notify();
  }

  void _notify() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
