import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/bloc_event_state_builder.dart';
import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:flutter_bloc_events/blocslogin/aut_bloc.dart';
import 'package:flutter_bloc_events/blocslogin/aut_events.dart';
import 'package:flutter_bloc_events/blocslogin/aut_state.dart';
import 'package:flutter_bloc_events/telaslogin/aut_page.dart';
import 'package:flutter_bloc_events/telaslogin/homepage.dart';

class DecisionPage extends StatefulWidget {
  DecisionPage({Key? key}) : super(key: key);

  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  AutState? oldAutState;
  @override
  Widget build(BuildContext context) {
    AutBloc bloc = BlocProvider.of<AutBloc>(context);
    return BlocEventStateBuilder<AutEvent, AutState>(
      bloc: bloc,
      builder: (BuildContext context, AutState state) {
        if (state != oldAutState) {
          oldAutState = state;

          if (state.isAuthenticated) {
            _redirectToPage(context, const HomePage());
          } else if (state.isAuthenticating || state.isAuthenticated) {
          } else {
            _redirectToPage(context, const AutPage());
          }
        }
        return Container();
      },
    );
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
