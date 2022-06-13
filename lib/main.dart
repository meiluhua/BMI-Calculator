import 'package:bmi_calculator/calculator.dart';
import 'package:flutter/material.dart';

import 'Result.dart';

const defaultCardColor = Colors.black26;
const activeCardColor = Colors.grey;
const bottomColor = Color(0xFFEB1555);
const bottomMargin = EdgeInsets.only(top: 10);

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
      },
    );
  }
}

enum Gender { male, female, initial }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.initial;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: MyContainer(
                      color: selectedGender == Gender.male
                          ? activeCardColor
                          : defaultCardColor,
                      cardChild: SexWidget('MALE'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    child: MyContainer(
                      color: selectedGender == Gender.female
                          ? activeCardColor
                          : defaultCardColor,
                      cardChild: SexWidget('FEMALE'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyContainer(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Height',
                    style: TextStyle(fontSize: 25),
                  ),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text('cm'),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    activeColor: bottomColor,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MyContainer(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          weight.toString(),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              backgroundColor: Color(0xFF4C4F5E),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              backgroundColor: Color(0xFF4C4F5E),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MyContainer(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          age.toString(),
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              backgroundColor: Color(0xFF4C4F5E),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              backgroundColor: Color(0xFF4C4F5E),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              CalculatorBrain calculatorBrain = CalculatorBrain(height, weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResultPage(
                      calculatorBrain.calculateBMI(),
                      calculatorBrain.getResult(),
                      calculatorBrain.getInterpretation(),
                    );
                  },
                ),
              );
            },
            child: Container(
              color: bottomColor,
              margin: bottomMargin,
              padding: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: 80,
              child: Center(
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  final Color color;
  final Widget cardChild;

  MyContainer({color, cardChild})
      : color = color ?? defaultCardColor,
        cardChild = cardChild ?? Center();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }
}

class SexWidget extends StatelessWidget {
  final String sex;

  SexWidget(this.sex);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          sex,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
