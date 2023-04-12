import 'package:flutter/material.dart';
import 'package:itwillrock_mobile_ui/constants/colors.dart';
import 'package:itwillrock_mobile_ui/neumorphism.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      title: 'Flutter Demo',
      home: const Scaffold(
        //Here you can set what ever background color you need.
        backgroundColor: Colors.white,
        body: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double intensity1 = 1;
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Column(
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
      );
  }
}
