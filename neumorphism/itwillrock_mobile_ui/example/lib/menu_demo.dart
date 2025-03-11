import 'package:flutter/material.dart';

// App pages
import 'package:itwillrock_mobile_ui_example/demo/first.dart';
import 'package:itwillrock_mobile_ui_example/demo/second.dart';

// Neumorphism package
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/color_utils.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';
import 'package:itwillrock_neumorphism/menu/menu_container.dart';

// Local navigation
import 'navigation_wrapper.dart';
import 'navigation_service.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  // Constants
  static const _animationDuration = Duration(milliseconds: 300);
  static const double _menuShiftValue = 200.0;
  static const double _paddingValue = 16.0;
  static const int _darkenFactor = 20;
  static const List<String> _menuItems = ["Sample 1", "Sample 2"];

  // State
  late AnimationController _controller;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = NavigationService(const FirstPage());
    _controller =
        AnimationController(vsync: this, duration: _animationDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Menu actions
  void toggleMenu() => _controller.animateTo(_controller.value > 0 ? 0 : 1);
  void closeMenu() => _controller.animateTo(0);

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

  // UI Components
  Widget _buildMenu(BuildContext context, {String selectedItem = "Dashboard"}) {
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
          items: _menuItems,
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: toggleMenu,
          child: Padding(
            padding: const EdgeInsets.all(_paddingValue),
            child: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, value, __) =>
                  Neumorphism.menuButton(animationStep: value),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildContentContainer() {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (_, value, __) => MenuContainer(
        shiftValue: value * _menuShiftValue,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:
                BorderRadius.circular(Neumorphism.borderRadius * value),
          ),
          child: Column(
            children: [
              _buildAppHeader(),
              Expanded(child: _navigationService.currentWidget),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateThemeColors(context);
    final padding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => AnimatedContainer(
          duration: _animationDuration,
          color: ColorsUtils.darken(
              AppColors.mainColor, _darkenFactor * _controller.value.toInt()),
          padding: padding,
          child: NavigationWrapper(
            menu: _buildMenu(context),
            child: _buildContentContainer(),
          ),
        ),
      ),
    );
  }

  // Update theme colors based on the app's theme
  void _updateThemeColors(BuildContext context) {
    final themeData = Theme.of(context);

    AppColors.mainColor = themeData.colorScheme.surface;
    AppColors.textColor = themeData.textTheme.titleLarge!.color!;
    AppColors.lightShadowColor = ColorsUtils.lighten(AppColors.mainColor, 7);
    AppColors.darkShadowColor =
        ColorsUtils.darken(AppColors.mainColor, _darkenFactor);
    AppColors.accentColor = themeData.colorScheme.primary;
    AppColors.altAccentColor = themeData.colorScheme.secondary;
  }
}
