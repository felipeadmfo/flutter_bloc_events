import 'package:flutter_bloc_events/abstracao/bloc_event_state.dart';
import 'package:flutter_bloc_events/blocslogin/aut_events.dart';
import 'package:flutter_bloc_events/blocslogin/aut_state.dart';

class AutBloc extends BlocEventStateBase<AutEvent, AutState> {
  AutBloc() : super(initialState: AutState.notAuthenticated());

  @override
  Stream<AutState> eventHandler(AutEvent event, AutState currentState) async* {
    // Nesse método do eventHandler ao invés de verificar o atributo
    // type da classe do evento, será verificado o objeto instânciado
    // do evento com "is" uma vez que implementamos eventos como
    // especializações de uma classe abstrata.
    if (event is AutEventLogin) {
      yield AutState.authenticating();

      await Future.delayed(const Duration(seconds: 2));

      if (event.nome == "failure") {
        yield AutState.failure();
      } else {
        yield AutState.authenticated(event.nome);
      }
    }

    if (event is AutEventLogout) {
      yield AutState.notAuthenticated();
    }
  }
}
