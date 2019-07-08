import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInWitEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
//  Future<String> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements BaseAuth {
//  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // sign in
  Future<String> signInWitEmailAndPassword(String email, String password) async{
    FirebaseUser user = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  // create user
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  // async'ly get current user or null if there is none
  Future<String> currentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

//  @override
//  Future<String> signInWithGoogle() async {
//    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth =
//    await googleUser.authentication;
//
//    final FirebaseUser user = await firebaseAuth.signInWithGoogle(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//    assert(user.email != null);
//    assert(user.displayName != null);
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await firebaseAuth.currentUser();
//    assert(user.uid == currentUser.uid);
//
//    return user.uid;
//  }

}

