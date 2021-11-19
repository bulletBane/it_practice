import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: const MyScreen(),
      ),
    );
  }
}

class MaxMinWidget extends StatelessWidget {
  const MaxMinWidget(
      {Key? key, required this.max, required this.min, required this.currency})
      : super(key: key);
  final double max;
  final double min;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Text(
      'MAX for $currency is: $max, MIN for $currency is: $min',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AverageWidget extends StatelessWidget {
  const AverageWidget({Key? key, required this.average, required this.currency})
      : super(key: key);
  final double average;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Text(
      'AVERAGE for $currency is: $average',
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  ///cny[index]/75
  final List<double> cny = [0.87, 0.88, 0.89];

  ///rub[index]/75
  final List<double> rub = [0.07, 0.08, 0.09];

  double getAvgRub() {
    double sum = 0;
    for (double number in cny) {
      sum += number;
    }
    return sum / 3;
  }

  double getAvgCny() {
    double sum = 0;
    for (double number in rub) {
      sum += number;
    }
    return sum / 3;
  }

  @override
  void initState() {
    features = [
      Feature(
        title: "EURO",
        color: Colors.green,
        data: cny,
      ),
      Feature(
        title: "RUB",
        color: Colors.red,
        data: rub,
      ),
      Feature(
        title: "AVG",
        color: Colors.blue,
        data: [
          (cny[0] + rub[0]) / 2,
          (cny[1] + rub[1]) / 2,
          (cny[2] + rub[2]) / 2,
        ],
      ),
    ];
    super.initState();
  }

  late final List<Feature> features;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(),
        Text(
          "CNY \$\$\$ RUB",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        LineGraph(
          features: features,
          size: const Size(320, 400),
          labelX: const ['September', 'October', 'November'],
          labelY: const ['25', '50', '75'],
          showDescription: true,
          graphColor: Colors.white30,
          graphOpacity: 0.2,
          verticalFeatureDirection: true,
          descriptionHeight: 170,
        ),
        MaxMinWidget(
            max: cny.reduce((curr, next) => curr > next ? curr : next),
            min: cny.reduce((curr, next) => curr < next ? curr : next),
            currency: 'CNY'),
        MaxMinWidget(
            max: rub.reduce((curr, next) => curr > next ? curr : next),
            min: rub.reduce((curr, next) => curr < next ? curr : next),
            currency: 'RUB'),
        AverageWidget(average: getAvgRub(), currency: 'RUB'),
        AverageWidget(average: getAvgCny(), currency: 'CNY'),
      ],
    );
  }
}
