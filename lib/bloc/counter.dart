import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<Map<String, dynamic>> {
  CounterBloc() : super({"input": "", "output": ""});

  void changeInput(String newInput) {
    emit({
      "input": _validateInput(newInput),
      "output": state["output"],
    });
  }

  void changeOutput(String newOutput) {
    emit({
      "input": state["input"],
      "output": newOutput,
    });
  }

  _validateInput(String input) {
    // String result = "";

    // remove leading "0"
    // result = input.replaceAll(RegExp(r'^0+(?=.)'), '');

    return input;
  }
}
