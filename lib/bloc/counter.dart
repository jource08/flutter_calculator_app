import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<Map<String, dynamic>> {
  CounterBloc() : super({"input": "0", "output": 0});

  void changeInput(String newInput) {
    emit({
      "input": _validateInput(newInput),
      "output": state["output"],
    });
  }

  void changeOutput(int newOutput) {
    emit({
      "input": state["input"],
      "output": newOutput,
    });
  }

  _validateInput(String input) {
    String result = "";

    // remove leading "0"
    result = input.replaceAll(RegExp(r'^0+(?=.)'), '');

    // limit operator input
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    var isNumeric = numericRegex.hasMatch(result);
    if (!isNumeric) {
      if (result.length > 1) {
        var output = result[result.length - 2];
        var output2 = result[result.length - 1];
        var outputisNumeric = numericRegex.hasMatch(output);
        var output2isNumeric = numericRegex.hasMatch(output2);
        if (output == output2) {
          result = result.substring(0, result.length - 1);
        }
      }
    }

    return result;
  }
}
