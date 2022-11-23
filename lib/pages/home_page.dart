import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator_app/app_const/colors.dart';
import 'package:flutter_calculator_app/bloc/counter.dart';
import 'package:flutter_calculator_app/widgets/button.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("AA")),
      backgroundColor: Colors.black,
      body: _buildAppBody(context),
    );
  }

  Column _buildAppBody(BuildContext context) {
    debugPrint('render app');
    CounterBloc mycounter = context.read<CounterBloc>();
    String inputState = mycounter.state['input'];
    List operator = ["÷", "x", "-", "+"];

    String lastChar = "";

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BlocSelector<CounterBloc, Map<String, dynamic>, String>(
                  selector: (state) => state['input'],
                  builder: (context, state) {
                    debugPrint("build app input text");
                    return Text(
                      state,
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocSelector<CounterBloc, Map<String, dynamic>, String>(
                  selector: (state) => state['output'],
                  builder: (context, state) {
                    debugPrint("build app output text");
                    return Text(
                      state,
                      style: TextStyle(
                          fontSize: 48, color: Colors.white.withOpacity(0.7)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // button area
        Row(
          children: [
            CalculatorButton(
              text: "AC",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                inputState = "";
                mycounter.changeInput(inputState);
                mycounter.changeOutput("");
              },
            ),
            CalculatorButton(
              text: "<",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                if (inputState.isNotEmpty) {
                  inputState = inputState.substring(0, inputState.length - 1);
                  mycounter.changeInput(inputState);
                } else {
                  mycounter.changeInput("");
                }
              },
            ),
            CalculatorButton(
              text: "",
              buttonBgColor: Colors.transparent,
              buttonTapped: () {},
            ),
            CalculatorButton(
              text: "÷",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                mycounter.changeInput(inputState += "÷");
              },
            ),
          ],
        ),
        Row(
          children: [
            CalculatorButton(
              text: "7",
              buttonTapped: () {
                mycounter.changeInput(inputState += "7");
              },
            ),
            CalculatorButton(
              text: "8",
              buttonTapped: () {
                mycounter.changeInput(inputState += "8");
              },
            ),
            CalculatorButton(
              text: "9",
              buttonTapped: () {
                mycounter.changeInput(inputState += "9");
              },
            ),
            CalculatorButton(
              text: "x",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                mycounter.changeInput(inputState += "x");
              },
            ),
          ],
        ),
        Row(
          children: [
            CalculatorButton(
              text: "4",
              buttonTapped: () {
                mycounter.changeInput(inputState += "4");
              },
            ),
            CalculatorButton(
              text: "5",
              buttonTapped: () {
                mycounter.changeInput(inputState += "5");
              },
            ),
            CalculatorButton(
              text: "6",
              buttonTapped: () {
                mycounter.changeInput(inputState += "6");
              },
            ),
            CalculatorButton(
              text: "-",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                mycounter.changeInput(inputState += "-");
              },
            ),
          ],
        ),
        Row(
          children: [
            CalculatorButton(
              text: "1",
              buttonTapped: () {
                mycounter.changeInput(inputState += "1");
              },
            ),
            CalculatorButton(
              text: "2",
              buttonTapped: () {
                mycounter.changeInput(inputState += "2");
              },
            ),
            CalculatorButton(
              text: "3",
              buttonTapped: () {
                mycounter.changeInput(inputState += "3");
              },
            ),
            CalculatorButton(
              text: "+",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {
                mycounter.changeInput(inputState += "+");
              },
            ),
          ],
        ),
        Row(
          children: [
            CalculatorButton(
              text: "%",
              buttonBgColor: operatorColor,
              textColor: orangeColor,
              buttonTapped: () {},
            ),
            CalculatorButton(
              text: "0",
              buttonTapped: () {
                mycounter.changeInput(inputState += "0");
              },
            ),
            CalculatorButton(
              text: ".",
              buttonTapped: () {
                if (inputState.isNotEmpty) {
                  lastChar = inputState[inputState.length - 1];

                  // validate dot input for multiple block of number
                  for (var op in operator) {
                    var _n = inputState.split(op);
                    if (_n.length > 1 && _isDouble(_n[1])) {
                      mycounter.changeInput(inputState += ".");
                    }
                  }

                  if (_isDouble(inputState)) {
                    mycounter.changeInput(inputState += ".");
                  } else {
                    mycounter.changeInput(inputState);
                  }
                } else {
                  mycounter.changeInput("0.");
                }
              },
            ),
            CalculatorButton(
              text: "=",
              buttonBgColor: orangeColor,
              buttonTapped: () {
                if (inputState.isNotEmpty) {
                  mycounter.changeOutput(_equalPressed(inputState));
                }
              },
            ),
          ],
        )
      ],
    );
  }

  bool _isNumeric(String s) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(s);
  }

  bool _isDouble(String s) {
    bool valid = true;
    try {
      double.parse("$s.");
    } catch (e) {
      valid = false;
    }
    return valid;
  }

  String _equalPressed(String userInput) {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*').replaceAll('÷', "/");

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    List arrVal = eval.toString().split(".");
    String res = "";
    if (int.parse(arrVal[1]) > 0) {
      res = eval.toString();
    } else {
      res = eval.toInt().toString();
    }
    return res;
  }
}
