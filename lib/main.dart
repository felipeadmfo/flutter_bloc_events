import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:flutter_bloc_events/initialization_page.dart';
import 'package:flutter_bloc_events/reg_form.dart';
import 'package:flutter_bloc_events/telaslogin/decision_page.dart';

import 'blocslogin/aut_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AutBloc>(
        blocBuilder: () => AutBloc(),
        child: MaterialApp(
          routes: {
            '/decision': (context) => DecisionPage(),
          },
          title: 'BLoC Samples',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(body: RegistrationForm()),
        ));
  }
}
