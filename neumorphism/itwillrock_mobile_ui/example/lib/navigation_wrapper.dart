import 'package:flutter/material.dart';

class NavigationWrapper extends StatelessWidget {
  final Widget menu;
  final Widget child;

  const NavigationWrapper({super.key, required this.menu, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[menu, child],
    );
  }
}
