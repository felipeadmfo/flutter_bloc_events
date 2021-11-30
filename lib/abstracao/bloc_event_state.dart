import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocEvent extends Object {}

abstract class BlocState extends Object {}

abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {
  // Qualquer subject é um ouvinte e também um observável.
  // Ou seja, ele pode emitir informações para um ouvinte,
  // Mas pode estar ouvindo também outro observável;
  // Assim o BehaviorSubject, que implementa o fluxo de dados de um estado,
  // estará sempre ouvindo os eventos lançados pelo Subject responsável por
  // tratar desse tipo de dados.
  // Mas, também emitirá informações sobre a própria mudança de estado
  // causada por algum desses eventos.

  // Um fluxo para o controle de envento é definido como
  // publish, pois não é necessário que novos assinantes
  // "fiquem sabendo" dos enventos emitidos anteriormente.
  // Presume que se uma interface (uma lista) ainda não estava
  // Observando esse fluxo é porque seu comportamento não
  // precisaria ser afetado pelas informações geradas
  final PublishSubject<BlocEvent> _eventController =
      PublishSubject<BlocEvent>();
  // Já um estado é um dado de longa duração que precisa ser recuperado.
  // É necessário que um novo médico plantonista saiba qual é o estado
  // do paciente, mesmo que ele não estivesse acompanhando os eventos
  // anteriores.
  final BehaviorSubject<BlocState> _stateController =
      BehaviorSubject<BlocState>();

  // Um evento é sempre emitido através do subject _eventController
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  // O state é um stream que será lançado e armazenado por _stateController
  Stream<BlocState> get state => _stateController.stream;

  // Como dito anteriormente, subjects também podem assinar outros observáveis
  // Nesse caso, uma classe que irá especializar a BlocEventState deve implementar também,
  // um eventHandler que escutará o subject _eventController, irá manipular
  // as informações emitidas, e emitirá um novo estado através do _stateControle
  Stream<BlocState> eventHandler(BlocEvent event, BlocState currentState);

  final BlocState initialState;

  BlocEventStateBase({required this.initialState}) {
    _eventController.listen((BlocEvent event) {
      BlocState currentState = _stateController.value ?? initialState;
      eventHandler(event, currentState).forEach((BlocState newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
