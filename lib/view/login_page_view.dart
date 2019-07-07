import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/auth.dart';
import 'package:bitbuddy/utils/AppTheme.dart';

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
        title: new Text(_formType == FormType.login ? "Login Here" : "Register Here"),
      ),
      body: new Center(
        child: new Container(
          padding: EdgeInsets.all(10.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: inputFields() + submitButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> inputFields() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: "Email"),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (value) => value.isEmpty || value.length < 8 ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> submitButtons() {
    String primaryButton;
    String secondaryButton;
    if(_formType == FormType.login) {
      primaryButton = 'Login';
      secondaryButton = 'Don\'t have an account? Register';
    } else {
      primaryButton = 'Register';
      secondaryButton = 'Have an account? Login';
    }

    return [
      new RaisedButton(
          color: AppTheme.lightBlue,
          child: new Text(primaryButton,
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: submit),
      new FlatButton(
          onPressed: _formType == FormType.login ? goToRegister : goToLogin,
          child: new Text(secondaryButton,
              style: new TextStyle(fontSize: 20.0, color: AppTheme.lightBlue)))
    ];
  }
}
