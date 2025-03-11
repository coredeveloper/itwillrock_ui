import 'package:flutter/material.dart';
import 'package:itwillrock_neumorphism/charts/label_model.dart';
import 'package:itwillrock_neumorphism/constants/colors.dart';
import 'package:itwillrock_neumorphism/neumorphism.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  ValueNotifier<LabelSeriesModel> chartData =
      ValueNotifier<LabelSeriesModel>(LabelSeriesModel());
  double intensity1 = 1;

  void addDataToChart(double val, LabelSeriesModel model) {
    model.data.add(LabelModel(label: '$val', value: val));
  }

  @override
  void initState() {
    super.initState();

    addDataToChart(122, chartData.value);
    addDataToChart(2, chartData.value);
    addDataToChart(5, chartData.value);
    addDataToChart(23, chartData.value);
    chartData.value.referenceValue = 222;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Neumorphism.seriesChart(chartData),
        ),
        Row(
          children: [
            Expanded(
              child: Neumorphism.textFormField(
                renderAccent: true,
                accentAlignment: Alignment.centerLeft,
                accentIntensity: intensity1 * 0.5,
                hint: 'simple text',
              ),
            ),
            const SizedBox(
              width: 48,
              height: 18,
            ),
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
                    ))),
            Neumorphism.accentButton(
                size: const Size(60, 60),
                toggle: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.all(10),
                child: Icon(
                  Icons.fingerprint,
                  color: AppColors.mainColor,
                  size: 32,
                ))
          ],
        ),
        Neumorphism.emailFormField(
          hint: 'some email',
        ),
        Neumorphism.passwordFormField(
          renderAccent: true,
          accentAlignment: Alignment.bottomCenter,
          accentIntensity: intensity1,
          hint: 'some pwd',
        ),
      ],
    );
  }
}
