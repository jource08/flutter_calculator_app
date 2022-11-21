import 'package:flutter/material.dart';
import '../app_const/colors.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? buttonBgColor;
  final void Function() buttonTapped;
  const CalculatorButton(
      {Key? key,
      required this.text,
      this.textColor = Colors.white,
      this.buttonBgColor = buttonColor,
      required this.buttonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: buttonTapped,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // onPressed: () {
        //   var inputState = counterbloc.state['input'];
        //   // var arrText = text.split("");
        //   if (_isNumeric(text)) {
        //     counterbloc.changeInput("$inputState$text");
        //   } else {
        //     switch (text) {
        //       case "AC":
        //         counterbloc.changeInput("");
        //         break;
        //       case "<":
        //         if (inputState.length > 0) {
        //           counterbloc.changeInput(
        //               inputState.substring(0, inputState.length - 1));
        //         } else {
        //           counterbloc.changeInput("");
        //         }
        //         break;
        //       case "=":
        //         counterbloc.changeInput("");
        //         break;
        //       case "÷":
        //         if (inputState.length > 0) {
        //           var lastChar = inputState[inputState.length - 1];
        //           if (lastChar != text && !_isNumeric(lastChar)) {
        //             counterbloc.changeInput(
        //                 "${inputState.substring(0, inputState.length - 1)}$text");
        //           } else if (lastChar != "÷") {
        //             counterbloc.changeInput("$inputState$text");
        //           }
        //         }
        //         break;
        //       case "x":
        //         if (inputState.length > 0) {
        //           var lastChar = inputState[inputState.length - 1];
        //           if (lastChar != text && !_isNumeric(lastChar)) {
        //             counterbloc.changeInput(
        //                 "${inputState.substring(0, inputState.length - 1)}$text");
        //           } else if (lastChar != "x") {
        //             counterbloc.changeInput("$inputState$text");
        //           }
        //         }
        //         break;
        //       case "-":
        //         if (inputState.length > 0) {
        //           var lastChar = inputState[inputState.length - 1];
        //           if (lastChar != text && !_isNumeric(lastChar)) {
        //             counterbloc.changeInput(
        //                 "${inputState.substring(0, inputState.length - 1)}$text");
        //           } else if (lastChar != "-") {
        //             counterbloc.changeInput("$inputState$text");
        //           }
        //         }
        //         break;
        //       case "+":
        //         if (inputState.length > 0) {
        //           var lastChar = inputState[inputState.length - 1];
        //           if (lastChar != text && !_isNumeric(lastChar)) {
        //             counterbloc.changeInput(
        //                 "${inputState.substring(0, inputState.length - 1)}$text");
        //           } else if (lastChar != "+") {
        //             counterbloc.changeInput("$inputState$text");
        //           }
        //         }
        //         break;
        //       case ".":
        //         if (inputState.length > 0) {
        //           var lastChar = inputState[inputState.length - 1];
        //           if (lastChar != text && !_isNumeric(lastChar)) {
        //             counterbloc.changeInput(
        //                 "${inputState.substring(0, inputState.length - 1)}$text");
        //           } else if (lastChar != ".") {
        //             counterbloc.changeInput("$inputState$text");
        //           }
        //         } else {
        //           counterbloc.changeInput("0$text");
        //         }
        //         break;
        //       default:
        //     }
        //   }
        // },
      ),
    ));
  }

  bool _isNumeric(String s) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(s);
  }
}
