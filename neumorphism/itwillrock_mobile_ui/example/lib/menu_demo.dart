import 'package:flutter/material.dart';
import 'package:itwillrock_mobile_ui_example/demo/first.dart';
import 'package:itwillrock_mobile_ui_example/demo/second.dart';
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';
import 'package:itwillrock_neumorphism/color_utils.dart';
import 'package:itwillrock_neumorphism/menu/menu_container.dart';
import 'navigation_wrapper.dart';
import 'navigation_service.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late NavigationService _navigationService;
  static const int _animationDuration = 300;
  static const double _menuShiftValue = 200.0;
  static const double _paddingValue = 16.0;

  @override
  void initState() {
    super.initState();
    _navigationService = NavigationService(const Text("Sample 1"));
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: _animationDuration));
  }

  void toggleMenu() {
    _controller.animateTo(_controller.value > 0 ? 0 : 1);
  }

  void closeMenu() {
    _controller.animateTo(0);
  }

  void _selectItem(String value) {
    switch (value) {
      case 'Sample 1':
        _navigationService.navigateTo(const FirstPage());
        break;
      case 'Sample 2':
        _navigationService.navigateTo(const SecondPage());
        break;
    }
    closeMenu();
  }

  Widget menu(BuildContext context, {String selectedItem = "Dashboard"}) {
    return Container(
      color: AppColors.darkShadowColor,
      padding: const EdgeInsets.only(left: _paddingValue, top: 100, bottom: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Neumorphism.accentList(
            selectedItem: selectedItem,
            onItemSelected: _selectItem,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            items: [
              "Sample 1",
              "Sample 2",
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var padding = MediaQuery.of(context).viewPadding;
    const int darkerIndex = 20;
    AppColors.mainColor = themeData.colorScheme.surface;
    AppColors.textColor = themeData.textTheme.titleLarge!.color!;
    AppColors.lightShadowColor = ColorsUtils.lighten(AppColors.mainColor, 7);
    AppColors.darkShadowColor =
        ColorsUtils.darken(AppColors.mainColor, darkerIndex);
    AppColors.accentColor = themeData.colorScheme.primary;
    AppColors.altAccentColor = themeData.colorScheme.secondary;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: _animationDuration),
            color: ColorsUtils.darken(
                AppColors.mainColor, darkerIndex * _controller.value.toInt()),
            padding: padding,
            child: NavigationWrapper(
              menu: menu(context),
              child: MenuContainer(
                shiftValue: _controller.value * _menuShiftValue,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(
                      Neumorphism.borderRadius * _controller.value,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: toggleMenu,
                            child: Container(
                              padding: const EdgeInsets.all(_paddingValue),
                              alignment: Alignment.centerLeft,
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) =>
                                    Neumorphism.menuButton(
                                        animationStep: _controller.value),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: _navigationService.currentWidget,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
