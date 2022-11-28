import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator_app/pages/home_page.dart';

import 'bloc/counter.dart';
import 'bloc/theme.dart';

void main() {
  TextInputBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ], child: const HomePage()),
    );
  }
}
