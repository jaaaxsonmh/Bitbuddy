import 'package:flutter/material.dart';
import 'package:bitbuddy/utils/auth.dart';
import 'package:bitbuddy/utils/app_theme.dart';
import 'package:bitbuddy/widgets/stacked_icon.dart';

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

  void googleSignIn() async{
    try {
//      widget.auth.signInWithGoogle();
    } catch (e) {
      print(e);
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                    _formType == FormType.login
                        ? "Login to Bit Buddy"
                        : "Register for Bit Buddy",
                    style: new TextStyle(fontSize: 32.0),
                  ),
                )
              ],
            ),
            new Form(
              key: formKey,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: inputFields(),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new Container(
                  alignment: Alignment.center,
                  child: submitButtons()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new Container(
                  child: switchStates()),
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
          decoration: new InputDecoration(labelText: "Enter Email here"),
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),

        new TextFormField(
          decoration: new InputDecoration(labelText: "Enter Password here"),
          obscureText: true,
          validator: (value) => value.isEmpty
              ? 'Password can\'t be empty'
              : value.length < 8
                  ? "Password can\'t be less than 8 characters"
                  : null,
          onSaved: (value) => _password = value,
        )
      ],
    );
  }

  Widget loginWithGoogle() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new FlatButton(
            onPressed: googleSignIn,
            child: new Image(image: new AssetImage("images/google.png"))),
      ],
    );
  }

  Widget switchStates() {
    String secondaryButton;

    if (_formType == FormType.login) {
      secondaryButton = 'Don\'t have an account? Register';
    } else {
      secondaryButton = 'Already have an account? Login';
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new FlatButton(
            onPressed: _formType == FormType.login ? goToRegister : goToLogin,
            child: new Text(secondaryButton,
                style: new TextStyle(
                    fontSize: 18.0, color: Colors.lightBlueAccent))),
      ],
    );
  }

  Widget submitButtons() {
    String primaryButton;

    if (_formType == FormType.login) {
      primaryButton = 'Login';
    } else {
      primaryButton = 'Register';
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new RaisedButton(
            color: AppTheme.lightBlue,
            child: new Text(primaryButton,
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: submit),
      ],
    );
  }
}
