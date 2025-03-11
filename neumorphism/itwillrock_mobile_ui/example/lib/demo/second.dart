import 'package:flutter/material.dart';
import 'package:itwillrock_neumorphism/charts/label_model.dart';
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  accentAligment: const Alignment(1, -1),
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
                  accentAligment: const Alignment(1, 0),
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
                  accentAligment: const Alignment(1, -1),
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
          const SizedBox(
            height: 130,
          ),
        ],
      ),
    );
  }
}
