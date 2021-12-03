import 'package:flutter_bloc_events/abstracao/bloc_event_state.dart';

class AutState extends BlocState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;

  final String nome;

  AutState(
      {required this.isAuthenticated,
      this.isAuthenticating = false,
      this.hasFailed = false,
      this.nome = ""});

  factory AutState.notAuthenticated() {
    return AutState(
      isAuthenticated: false,
    );
  }

  factory AutState.authenticated(String nome) {
    return AutState(
      isAuthenticated: true,
      nome: nome,
    );
  }

  factory AutState.authenticating() {
    return AutState(
      isAuthenticated: false,
      isAuthenticating: true,
    );
  }

  factory AutState.failure() {
    return AutState(
      isAuthenticated: false,
      hasFailed: true,
    );
  }
}
