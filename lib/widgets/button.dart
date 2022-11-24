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
      ),
    ));
  }
}
