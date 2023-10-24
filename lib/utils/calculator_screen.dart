import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class SecondCalcScreen extends StatefulWidget {
  @override
  _SecondCalcScreenState createState() => _SecondCalcScreenState();
}

class _SecondCalcScreenState extends State<SecondCalcScreen> {
  String userInput = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Простой калькулятор",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Введите выражение"),
            onChanged: (value) {
              setState(() {
                userInput = value;
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              calculateResult();
            },
            child: Text("Рассчитать"),
          ),
          SizedBox(height: 16),
          Text(
            "Результат: $result",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  void calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = "Ошибка";
      });
    }
  }
}
