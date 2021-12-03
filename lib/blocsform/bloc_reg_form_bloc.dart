import 'dart:async';

import 'package:flutter_bloc_events/abstracao/blocprovider.dart';
import 'package:flutter_bloc_events/validadores/email_validator.dart';
import 'package:flutter_bloc_events/validadores/password_validator.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationFormBloc extends Object
    with EmailValidator, PasswordValidator
    implements BlocBase {
  // Cada Campo do formulário terá seu valor controlado por um BehaviorSubject
  // Responsável por armazenar seu valor retorná-lo
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _confirmController = BehaviorSubject<String>();

  //

  Function(String) get onEmailChanged => _emailController.sink.add;
  Function(String) get onPasswordChanged => _passwordController.sink.add;
  Function(String) get onConfirmChanged => _confirmController.sink.add;

  // Para validar os dados serão usado transformers que literalmente transforma
  // um stream para outro. A Função responsável por essa transformação estará e, EmailValidator
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  // Além da validação quando a confirmação receber um valor transformado ainda
  // será verificado se os valores da confirmação e email são iguais;
  Stream<String> get confirm => _confirmController.stream
          .transform(validatePassword)
          .doOnData((String c) {
        if (0 != _passwordController.value.compareTo(c)) {
          _confirmController
              .addError("Confirmação da senha diferente da cadastrada");
        }
      });

  Stream<bool> get registerValid =>
      Rx.combineLatest3(email, password, confirm, (e, p, c) => true);
  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _confirmController.close();
  }
}
