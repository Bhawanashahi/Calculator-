import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String userInput = '';
  String result = '';

  List<String> str = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
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
              border: OutlineInputBorder(
              ),
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
                      color: Colors.yellow,  // Set the background color to grey
                      borderRadius: BorderRadius.circular(50.0),  // Set border radius
                      border: Border.all(),

                    ),
                    child: Text(str[index],
                    style: TextStyle(color: Colors.black),),
                    
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
      } else {
        userInput += buttonText;
      }
    });
  }

  String _calculateResult(String input) {
    try {
      // Evaluate the expression
      // Using 'try-catch' for basic error handling
      // Not suitable for handling all edge cases in production
      // For a more comprehensive solution, consider using a parser library
      // or adopting a more robust error-handling strategy.
      // This is a simplified example for demonstration purposes only.
      // Avoid using eval for production due to security vulnerabilities.
      return eval(input).toString();
    } catch (e) {
      return 'Error';
    }
  }

  double eval(String expression) {
    // Split the expression into operands and operators
    List<String> parts = expression.split(RegExp(r'(\+|-|\*|/)'));
    List<String> operations = expression.split(RegExp(r'[0-9]|[.]'));

    double total = double.parse(parts[0]);

    for (int i = 1; i < parts.length; i++) {
      double current = double.parse(parts[i]);
      String operation = operations[i];

      switch (operation) {
        case '+':
          total += current;
          break;
        case '-':
          total -= current;
          break;
        case '*':
          total *= current;
          break;
        case '/':
          total /= current;
          break;
        default:
          break;
      }
    }

    return total;
  }
}