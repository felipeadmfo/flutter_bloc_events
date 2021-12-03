// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/bloc_event_state_builder.dart';
import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:flutter_bloc_events/blocslogin/aut_bloc.dart';
import 'package:flutter_bloc_events/blocslogin/aut_events.dart';
import 'package:flutter_bloc_events/blocslogin/aut_state.dart';

class AutPage extends StatelessWidget {
  const AutPage({Key? key}) : super(key: key);

  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AutBloc bloc = BlocProvider.of<AutBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Autenticação"),
            leading: Container(),
          ),
          body: BlocEventStateBuilder<AutEvent, AutState>(
              bloc: bloc,
              builder: (BuildContext context, AutState state) {
                if (state.isAuthenticating) {
                  return const CircularProgressIndicator();
                }
                if (state.isAuthenticated) {
                  return Container();
                }
                List<Widget> children = <Widget>[];
                children.add(ListTile(
                  title: RaisedButton(
                    child: const Text("Login in (success)"),
                    onPressed: () {
                      bloc.emitEvent(AutEventLogin(nome: 'Felipe'));
                    },
                  ),
                ));

                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: const Text('Log in (failure)'),
                      onPressed: () {
                        bloc.emitEvent(AutEventLogin(nome: 'failure'));
                      },
                    ),
                  ),
                );

                if (state.hasFailed) {
                  children.add(const Text("Falha no Login"));
                }

                return Column(
                  children: children,
                );
              }),
        ),
      ),
    );
  }
}
