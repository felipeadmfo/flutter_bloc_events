import 'package:flutter/material.dart';
import 'package:flutter_bloc_events/blocsform/bloc_reg_form_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late RegistrationFormBloc _registrationFormBloc;

  @override
  void initState() {
    super.initState();
    _registrationFormBloc = RegistrationFormBloc();
  }

  @override
  void dispose() {
    _registrationFormBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
              stream: _registrationFormBloc.email,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'email',
                    errorText: snapshot.error?.toString(),
                  ),
                  onChanged: _registrationFormBloc.onEmailChanged,
                  keyboardType: TextInputType.emailAddress,
                );
              }),
          StreamBuilder<String>(
              stream: _registrationFormBloc.password,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'password',
                    errorText: snapshot.error?.toString(),
                  ),
                  obscureText: false,
                  onChanged: _registrationFormBloc.onPasswordChanged,
                );
              }),
          StreamBuilder<String>(
              stream: _registrationFormBloc.confirm,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'retype password',
                    errorText: snapshot.error?.toString(),
                  ),
                  obscureText: false,
                  onChanged: _registrationFormBloc.onConfirmChanged,
                );
              }),
          StreamBuilder<bool>(
              stream: _registrationFormBloc.registerValid,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return RaisedButton(
                  child: const Text('Register'),
                  onPressed: (snapshot.hasData && snapshot.data == true)
                      ? () {
                          // launch the registration process
                        }
                      : null,
                );
              }),
        ],
      ),
    );
  }
}
