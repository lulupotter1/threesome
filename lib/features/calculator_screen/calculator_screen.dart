import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:threescreens/features/calculator_screen/widgets/custom_button.dart';
import 'package:threescreens/features/weather_screen/presentation/widgets/custom_text_field.dart';

enum CalcEnum {
  plus,
  minus,
  multiply,
  divide,
}

@RoutePage()
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController calcController = TextEditingController();

  String prevData = "0";
  CalcEnum? calcEnum;
  bool afterEqual = false;
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      '1',
      '2',
      '3',
      '+',
      '4',
      '5',
      '6',
      '-',
      '7',
      '8',
      '9',
      '/',
      'C',
      '0',
      '=',
      '*',
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Calculator Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
              controller: calcController,
              labelTitle: "Calculator",
              hintText: "Calculator",
              enabled: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  if (items[index].isEmpty) {
                    return const SizedBox();
                  } else {
                    return CustomButton(
                      text: items[index],
                      onTap: () {
                        if (items[index] == '=') {
                          if (calcEnum != null && prevData.isNotEmpty && calcController.text.isNotEmpty) {
                            double prev = double.parse(prevData);
                            double current = double.parse(calcController.text);

                            switch (calcEnum!) {
                              case CalcEnum.plus:
                                calcController.text = (prev + current).toString();
                              case CalcEnum.minus:
                                calcController.text = (prev - current).toString();
                              case CalcEnum.divide:
                                calcController.text = (prev / current).toString();
                              case CalcEnum.multiply:
                                calcController.text = (prev * current).toString();
                            }
                            afterEqual = true;
                            prevData = "";
                            calcEnum = null;
                          }
                        } else if (items[index] == 'C') {
                          calcController.text = '';
                          prevData = "";
                        } else if (items[index] == '+') {
                          if (calcController.text.isNotEmpty) {
                            prevData = calcController.text;
                            calcEnum = CalcEnum.plus;
                            calcController.text = '';
                          }
                        } else if (items[index] == '-') {
                          if (calcController.text.isNotEmpty) {
                            prevData = calcController.text;
                            calcEnum = CalcEnum.minus;
                            calcController.text = '';
                          }
                        } else if (items[index] == '*') {
                          if (calcController.text.isNotEmpty) {
                            prevData = calcController.text;
                            calcEnum = CalcEnum.multiply;
                            calcController.text = '';
                          }
                        } else if (items[index] == '/') {
                          if (calcController.text.isNotEmpty) {
                            prevData = calcController.text;
                            calcEnum = CalcEnum.divide;
                            calcController.text = '';
                          }
                        } else {
                          if (afterEqual) {
                            calcController.text = items[index];

                            afterEqual = false;
                          } else {
                            calcController.text = calcController.text + items[index];
                          }
                        }
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context).replaceNamed("/");
                      // CoreBlocs.weather.add()
                    },
                    child: const Text(
                      "Weather Screen",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context).replaceNamed("/firstScreen");
                    },
                    child: const Text(
                      "First Screen",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
