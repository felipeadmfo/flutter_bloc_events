import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/abstracao/bloc_event_state.dart';

// Um tipo que define um builder(construtor especifico)
// que recebe um context e um state
typedef AsyncBlocEventStateBuilder<BlocState> = Widget Function(
    BuildContext context, BlocState state);

class BlocEventStateBuilder extends StatelessWidget {
  // Disponiliza para árvore envolvida e capacidade
  // de emitir evento e obervar a evolução do estado
  final BlocEventStateBase<BlocEvent, BlocState> bloc;

  final AsyncBlocEventStateBuilder<BlocState> builder;

  const BlocEventStateBuilder(
      {Key? key, required this.builder, required this.bloc})
      : super(key: key);

  // Um Widget envolvido por esse construtor sempre
  // reagirá a cada emissão de estado e também terá um estado inicial

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.state,
        initialData: bloc.initialState,
        builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
          return builder(context, snapshot.data!);
        });
  }
}
