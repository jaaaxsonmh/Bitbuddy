import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/auth.dart';

class LoginPageView extends StatefulWidget {
  LoginPageView({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

enum FormType { login, register }

class LoginPageState extends State<LoginPageView> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool save() {
    final form = formKey.currentState;

    if(form.validate()) {
      form.save();
      print('valid. Email: $_email, password: $_password');
      return true;
    }
    return false;
  }

  void submit() async {
    if(save()) {
      try {
        if(_formType == FormType.login) {
          String uid = await widget.auth.signInWitEmailAndPassword(_email, _password);
        } else {
          String uid = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        }
        widget.onSignedIn();
      } catch (e) {
        print('$e');
      }
    }
  }

  void goToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void goToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
