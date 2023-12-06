import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String userInput = '';
  String result = '';

  List<String> str = [
    "C", "*", "/", "<-", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "x", "%", "0", ".", "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Calculator App")),
      ),
      body: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            controller: TextEditingController(text: userInput),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 3,
              ),
              itemCount: str.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onButtonPressed(str[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isOperator(str[index])
                          ? Colors.grey[300]
                          : isFunctionButton(str[index])
                          ? Colors.grey[300]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(),
                    ),
                    child: Text(
                      str[index],
                      style: TextStyle(
                        color: isOperator(str[index]) ? Colors.black : Colors.black,
                        fontSize: isFunctionButton(str[index]) ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        userInput = '';
        result = '';
      } else if (buttonText == "=") {
        if (userInput.isNotEmpty &&
            userInput != '.' &&
            userInput != '+' &&
            userInput != '-' &&
            userInput != '*' &&
            userInput != '/') {
          result = _calculateResult(userInput);
          userInput = result;
        }
      } else if (buttonText == "<-" && userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      } else {
        userInput += buttonText;
      }
    });
  }

  String _calculateResult(String input) {
    try {
      input = input.replaceAll('x', '*');
      input = input.replaceAll('%', '/100');

      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      return evalResult.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }

  bool isOperator(String buttonText) {
    return buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/';
  }

  bool isFunctionButton(String buttonText) {
    return buttonText == 'C' || buttonText == '=' || buttonText == '<-';
  }
}

