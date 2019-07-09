import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInWitEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentEmail();

  Future<String> currentURL();

  Future<String> currentDisplayName();

  Future<void> signOut();
}

class Auth implements BaseAuth {
//  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;


  // sign in
  Future<String> signInWitEmailAndPassword(
      String email, String password) async {
    _user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _user.uid;
  }

  // create user
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    _user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _user.uid;
  }

  Future<String> currentEmail() async {
    return _user.email;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<String> currentDisplayName() async {
    return _user.displayName;
  }

  @override
  Future<String> currentURL() async {
    return _user.photoUrl;
  }
}
