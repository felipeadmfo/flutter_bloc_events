import 'package:flutter_bloc_events/abstracao/bloc_event_state.dart';

//Para permitir a passagem de parâmetros ao emitir um evento
// é possível implementar cada evento como uma classe que
// estende uma classe abstrata que define os atributos básicos como evento.
abstract class AutEvent extends BlocEvent {
  final String nome;
  AutEvent({this.nome = ''});
}

// A classe que implementa o evento login
// usa o construtor da classe abstrata para passar um valor para o nome
class AutEventLogin extends AutEvent {
  AutEventLogin({required String nome}) : super(nome: nome);
}

// Já a classe para o evento logout
// inicializa com o parâmetro nome conforme definido na classe abstrata.
class AutEventLogout extends AutEvent {}
