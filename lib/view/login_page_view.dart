import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/auth.dart';
import 'package:bitbuddy/utils/AppTheme.dart';
import 'package:bitbuddy/widgets/StackedIcon.dart';

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

    if (form.validate()) {
      form.save();
      print('valid. Email: $_email, password: $_password');
      return true;
    }
    return false;
  }

  void submit() async {
    if (save()) {
      try {
        if (_formType == FormType.login) {
          String uid =
              await widget.auth.signInWitEmailAndPassword(_email, _password);
        } else {
          String uid = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
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
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor:  Colors.transparent,
        elevation: 0.0,
        title: new Text(_formType == FormType.login ? "Login Here" : "Register Here"),
      ),
      body: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new StackedIcon(),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: new Text(
                    _formType == FormType.login ? "Login to Bit Buddy" : "Register for Bit Buddy",
                    style: new TextStyle(fontSize: 32.0, color: Colors.lightBlueAccent),
                  ),
                )
              ],
            ),
            new Form(
              key: formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  inputFields(),
                  submitButtons()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputFields() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(labelText: "Email"),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: "Password"),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Password can\'t be empty' : value.length < 8 ? "Password can\'t be less than 8 characters" : null,
          onSaved: (value) => _password = value,
        )
      ] ,
    );
  }

  Widget submitButtons() {
    String primaryButton;
    String secondaryButton;
    if(_formType == FormType.login) {
      primaryButton = 'Login';
      secondaryButton = 'Don\'t have an account? Register';
    } else {
      primaryButton = 'Register';
      secondaryButton = 'Have an account? Login';
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new RaisedButton(
            color: AppTheme.lightBlue,
            child: new Text(primaryButton,
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: submit),
        new FlatButton(
            onPressed: _formType == FormType.login ? goToRegister : goToLogin,
            child: new Text(secondaryButton,
                style: new TextStyle(fontSize: 20.0, color: AppTheme.lightBlue)))
      ],
    );
  }
}
