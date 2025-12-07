import 'package:flutter/material.dart';

// App pages
import 'package:itwillrock_mobile_ui_example/demo/first.dart';
import 'package:itwillrock_mobile_ui_example/demo/second.dart';

// Neumorphism package
import 'package:itwillrock_neumorphism/constants/colors.dart';
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
  static const List<String> _menuItems = ["Sample 1", "Sample 2"];

  // State
  late AnimationController _controller;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = NavigationService(
      FirstPage(navigationService: null), // Will be set properly in resetTo
      'Sample 1',
    );
    // Set the initial page with navigation service
    _navigationService.resetTo(
      FirstPage(navigationService: _navigationService),
      'Sample 1',
    );
    _navigationService.addListener(_onNavigationChanged);
    _controller =
        AnimationController(vsync: this, duration: _animationDuration);
  }

  @override
  void dispose() {
    _navigationService.removeListener(_onNavigationChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onNavigationChanged() {
    // Rebuild when navigation changes
    setState(() {});
  }

  // Menu actions
  void toggleMenu() => _controller.animateTo(_controller.value > 0 ? 0 : 1);
  void closeMenu() => _controller.animateTo(0);

  void _selectItem(String value) {
    switch (value) {
      case 'Sample 1':
        _navigationService.resetTo(
          FirstPage(navigationService: _navigationService),
          'Sample 1',
        );
        break;
      case 'Sample 2':
        _navigationService.resetTo(
          SecondPage(navigationService: _navigationService),
          'Sample 2',
        );
        break;
    }
    closeMenu();
  }

  void _handleBack() {
    if (_navigationService.canGoBack) {
      _navigationService.pop();
    }
  }

  // UI Components
  Widget _buildMenu(BuildContext context) {
    return Container(
      color: AppColors.darkShadowColor,
      padding: const EdgeInsets.only(left: _paddingValue, top: 100, bottom: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Neumorphism.accentList(
          selectedItem: _menuItems.contains(_navigationService.currentTitle)
              ? _navigationService.currentTitle
              : _menuItems.first,
          onItemSelected: _selectItem,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          items: _menuItems,
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    final canGoBack = _navigationService.canGoBack;
    final nestingLevel = _navigationService.nestingLevel;

    return Row(
      children: [
        // Show menu button OR back button depending on state
        if (canGoBack)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _handleBack,
            child: Padding(
              padding: const EdgeInsets.all(_paddingValue),
              // Use nested back button to show navigation depth
              child: Neumorphism.nestedBackButton(
                nestingLevel: nestingLevel - 1, // -1 because root is level 1
                size: 24,
              ),
            ),
          )
        else
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

        // Title
        if (_navigationService.currentTitle.isNotEmpty)
          Expanded(
            child: Neumorphism.text(
              _navigationService.currentTitle,
              size: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        else
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
              Expanded(
                child: _NestedNavigationWrapper(
                  navigationService: _navigationService,
                ),
              ),
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
          color: Color.lerp(
              AppColors.mainColor, Colors.black, _controller.value * 0.2),
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

    // Configure neumorphic colors from theme
    // Shadow colors are automatically derived from the background
    AppColors.configure(
      backgroundColor: themeData.colorScheme.surface,
      accent: themeData.colorScheme.primary,
      altAccent: themeData.colorScheme.secondary,
    );
  }
}

/// Wrapper that rebuilds when navigation changes
class _NestedNavigationWrapper extends StatelessWidget {
  final NavigationService navigationService;

  const _NestedNavigationWrapper({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: navigationService,
      builder: (context, _) => navigationService.currentWidget,
    );
  }
}
