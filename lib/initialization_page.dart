import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/bloc_event_state_builder.dart';
import 'package:flutter_bloc_events/blocs/app_initialization_bloc.dart';
import 'package:flutter_bloc_events/blocs/app_initialization_event.dart';
import 'package:flutter_bloc_events/blocs/app_initialization_state.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({Key? key}) : super(key: key);

  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  late AppInitializationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppInitializationBloc();
    bloc.emitEvent(AppInitializationEvent());
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child:
          BlocEventStateBuilder<AppInitializationEvent, AppInitializationState>(
        bloc: bloc,
        builder: (BuildContext context, AppInitializationState state) {
          if (state.isInitialized) {
            return const Text("App Inicializado");
          }
          return Text('Inicialização em progresso... ${state.progress}%');
        },
      ),
    ));
  }
}
