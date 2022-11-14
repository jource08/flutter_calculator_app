import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator_app/app_const/colors.dart';
import 'package:flutter_calculator_app/bloc/counter.dart';

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
    CounterBloc mycounter = context.read<CounterBloc>();
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
            _buildButton(mycounter,
                text: "AC",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
            _buildButton(mycounter,
                text: "<",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
            _buildButton(mycounter,
                text: "", buttonBgColor: Colors.transparent),
            _buildButton(mycounter,
                text: "/",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
          ],
        ),
        Row(
          children: [
            _buildButton(mycounter, text: "7"),
            _buildButton(mycounter, text: "8"),
            _buildButton(mycounter, text: "9"),
            _buildButton(mycounter,
                text: "x",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
          ],
        ),
        Row(
          children: [
            _buildButton(mycounter, text: "4"),
            _buildButton(mycounter, text: "5"),
            _buildButton(mycounter, text: "6"),
            _buildButton(mycounter,
                text: "-",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
          ],
        ),
        Row(
          children: [
            _buildButton(mycounter, text: "1"),
            _buildButton(mycounter, text: "2"),
            _buildButton(mycounter, text: "3"),
            _buildButton(mycounter,
                text: "+",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
          ],
        ),
        Row(
          children: [
            _buildButton(mycounter,
                text: "%",
                buttonBgColor: operatorColor,
                textColor: orangeColor),
            _buildButton(mycounter, text: "0"),
            _buildButton(mycounter, text: "."),
            _buildButton(
              mycounter,
              text: "=",
              buttonBgColor: orangeColor,
            ),
          ],
        )
      ],
    );
  }

  Expanded _buildButton(CounterBloc counterbloc,
      {String text = "0",
      Color textColor = Colors.white,
      Color buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          var inputState = counterbloc.state['input'];
          // var arrText = text.split("");
          if (_isNumeric(text)) {
            counterbloc.changeInput("$inputState$text");
          } else {
            switch (text) {
              case "AC":
                counterbloc.changeInput("");
                break;
              case "<":
                if (inputState.length > 0) {
                  counterbloc.changeInput(
                      inputState.substring(0, inputState.length - 1));
                } else {
                  counterbloc.changeInput("");
                }
                break;
              case "=":
                counterbloc.changeInput("");
                break;
              case "/":
                if (inputState.length > 0) {
                  var lastChar = inputState[inputState.length - 1];
                  if (lastChar != text) {
                    counterbloc.changeInput("$inputState$text");
                  }
                }
                break;
              default:
            }
          }
        },
      ),
    ));
  }

  bool _isNumeric(String s) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(s);
  }
}
