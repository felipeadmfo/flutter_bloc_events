import 'dart:async';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EmailValidator {
  final StreamTransformer<String, String> validateEmail =
      StreamTransformer.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = RegExp(_kEmailRule);
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      sink.addError("Entre com um email válido");
    } else {
      sink.add(email);
    }
  });
}
