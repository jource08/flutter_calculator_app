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
                  builder: (context, state) => Text(
                    state,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                BlocSelector<CounterBloc, Map<String, dynamic>, int>(
                  selector: (state) => state['output'],
                  builder: (context, state) => Text(
                    "$state",
                    style: TextStyle(
                        fontSize: 48, color: Colors.white.withOpacity(0.7)),
                  ),
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
                textColor: orangeColor,
                isInput: false),
            _buildButton(mycounter,
                text: "<",
                buttonBgColor: operatorColor,
                textColor: orangeColor,
                isInput: false),
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
              isInput: false,
            ),
          ],
        )
      ],
    );
  }

  Expanded _buildButton(CounterBloc counterbloc,
      {String text = "0",
      Color textColor = Colors.white,
      Color buttonBgColor = buttonColor,
      bool isInput = true}) {
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
          if (isInput) {
            counterbloc.changeInput("${counterbloc.state['input']}$text");
          } else {
            switch (text) {
              case "AC":
                counterbloc.changeInput("0");
                break;
              case "<":
                if (counterbloc.state['input'].length > 1) {
                  counterbloc.changeInput(counterbloc.state['input']
                      .substring(0, counterbloc.state['input'].length - 1));
                } else {
                  counterbloc.changeInput("0");
                }
                break;
              default:
            }
          }
        },
      ),
    ));
  }
}
