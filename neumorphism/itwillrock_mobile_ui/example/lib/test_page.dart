import 'package:flutter/material.dart';
import 'package:itwillrock_mobile_ui/constants/colors.dart';
import 'package:itwillrock_mobile_ui/neumorphism.dart';

class TestPageView extends StatefulWidget {
  const TestPageView({super.key});

  @override
  TestPageViewState createState() => TestPageViewState();
}

class TestPageViewState extends State<TestPageView> {
  double intensity1 = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Neumorphism.textFormField(
            hint: 'some hint2',
          ),
          Neumorphism.container(
              dropInnerShadow: false,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              accentAligment: const Alignment(0, 1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Neumorphism.container(
                      dropInnerShadow: false,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      accentAligment: const Alignment(1, -1),
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
                  Neumorphism.frostedGlassContainer(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    dropShadow: true,
                    dropInnerShadow: true,
                    child: const SizedBox(
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
              Neumorphism.softRoundButton(
                  accentAligment: const Alignment(-0.3, -1),
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
              Neumorphism.indicatorButton(
                  accentAligment: const Alignment(-1, -1),
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
            ],
          ),
          Neumorphism.checkBox(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(0),
          ),
          Neumorphism.softRoundButton(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              size: const Size(96, 42),
              text: "Login"),
          Neumorphism.softRoundButton(
              main: true,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              size: const Size(96, 42),
              text: "Login")
        ],
      ),
    );
  }
}
