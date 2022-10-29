import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Cubit<Map<String, dynamic>> {
  CounterBloc() : super({"input": "0", "output": 0});

  void changeInput(String newInput) {
    emit({
      "input": newInput,
      "output": state["output"],
    });
  }

  void changeOutput(int newOutput) {
    emit({
      "input": state["input"],
      "output": newOutput,
    });
  }
}


// class CounterBloc extends Cubit<int> {
//   CounterBloc() : super(0);

//   void add() => emit(state + 1);
//   void remove() => emit(state - 1);
// }
