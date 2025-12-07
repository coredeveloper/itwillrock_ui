import 'package:flutter/material.dart';
import 'package:itwillrock_neumorphism/charts/label_model.dart';
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';

import '../navigation_service.dart';

class SecondPage extends StatefulWidget {
  final NavigationService? navigationService;

  const SecondPage({Key? key, this.navigationService}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  double intensity1 = 1;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  ValueNotifier<LabelSeriesModel> chartData =
      ValueNotifier<LabelSeriesModel>(LabelSeriesModel());

  void addDataToChart(double val, LabelSeriesModel model) {
    model.data.add(LabelModel(label: '$val', value: val));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _heightAnimation = Tween<double>(begin: 10, end: 160).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    addDataToChart(122, chartData.value);
    addDataToChart(2, chartData.value);
    addDataToChart(5, chartData.value);
    addDataToChart(23, chartData.value);
    chartData.value.referenceValue = 222;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToDetails() {
    widget.navigationService?.navigateTo(
      DetailsPage(navigationService: widget.navigationService),
      'Details',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Neumorphism.frostedGlassContainer(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  dropShadow: true,
                  dropInnerShadow: true,
                  child: SizedBox(
                    height: _heightAnimation.value,
                  )),
            ),
          ],
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Neumorphism.softRoundButton(
                  accentAlignment: const Alignment(1, -1),
                  renderAccent: true,
                  accentIntensity: intensity1,
                  size: const Size(74, 74),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(37)),
                  margin: const EdgeInsets.all(10),
                  icon: const Icon(
                    Icons.fingerprint,
                    color: Color(0xFFADBAC7),
                    size: 32,
                  )),
              Neumorphism.container(
                  dropInnerShadow: false,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  accentAlignment: const Alignment(1, 0),
                  renderAccent: true,
                  accentIntensity: intensity1,
                  child: Container(
                    child: Neumorphism.softRoundButton(
                        size: const Size(60, 60),
                        toggle: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        margin: const EdgeInsets.all(10),
                        icon: Icon(
                          Icons.home,
                          color: AppColors.accentColor,
                          size: 32,
                        )),
                  )),
              Neumorphism.container(
                dropInnerShadow: false,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Neumorphism.accentButton(
                    size: const Size(60, 60),
                    toggle: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    margin: const EdgeInsets.all(10),
                    accentChanged: (intensity) {
                      setState(() {
                        intensity1 = intensity;
                      });
                    },
                    child: Icon(
                      Icons.fingerprint,
                      color: AppColors.mainColor,
                      size: 32,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Neumorphism.indicatorButton(
                  accentAlignment: const Alignment(1, -1),
                  accentColor: AppColors.accentColor,
                  accentIntensity: intensity1 * 0.5,
                  size: 74,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(37)),
                  margin: const EdgeInsets.all(10),
                  icon: const Icon(
                    Icons.fingerprint,
                    color: Color(0xFFADBAC7),
                    size: 32,
                  )),
              Neumorphism.checkBox(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(0),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Neumorphism.softRoundButton(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              size: const Size(96, 42),
              text: "Login"),
          const SizedBox(
            height: 30,
          ),
          Neumorphism.softRoundButton(
              main: true,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              size: const Size(96, 42),
              onTap: () {
                if (_animationController.status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
              },
              text: "Login"),
          // Nested navigation demo
          if (widget.navigationService != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Neumorphism.actionContainer(
                margin: 8,
                size: const Size(double.infinity, 48),
                onTap: _navigateToDetails,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: AppColors.textColor, size: 20),
                    const SizedBox(width: 8),
                    Neumorphism.text('View Details', size: 16),
                    const SizedBox(width: 8),
                    Icon(Icons.chevron_right, color: AppColors.textColor, size: 20),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 130,
          ),
        ],
      ),
    );
  }
}

/// Details page - demonstrates nested navigation from Sample 2
class DetailsPage extends StatelessWidget {
  final NavigationService? navigationService;

  const DetailsPage({Key? key, this.navigationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphism.text('Details', size: 24, fontWeight: FontWeight.bold),
          const SizedBox(height: 24),
          Neumorphism.container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Neumorphism.text('Nested Navigation Demo', size: 18),
                const SizedBox(height: 16),
                Neumorphism.text(
                  'This page demonstrates the nested back button feature. '
                  'Notice the "<" chevron in the header that takes you back.',
                  size: 14,
                ),
                const SizedBox(height: 16),
                Neumorphism.text(
                  'Try Sample 1 for deeper nesting (up to 3 levels) '
                  'to see <<< chevrons!',
                  size: 14,
                  color: AppColors.accentColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Neumorphism.softRoundButton(
              size: const Size(120, 48),
              text: 'Go Back',
              onTap: () => navigationService?.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
