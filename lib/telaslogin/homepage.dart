import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:flutter_bloc_events/blocslogin/aut_bloc.dart';
import 'package:flutter_bloc_events/blocslogin/aut_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child:
                    Column(children: const [Text("Home"), LogOutButton()]))));
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutBloc bloc = BlocProvider.of<AutBloc>(context);
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        bloc.emitEvent(AutEventLogout());
      },
    );
  }
}
