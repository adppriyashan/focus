import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:attrativenesstest/Models/User.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:attrativenesstest/Views/Auth/Login.dart';

class AuthController {
  static late FirebaseAuth _auth;
  late DatabaseReference _databaseRef;
  late GoogleSignIn _googleSignin;

  AuthController() {
    _auth = FirebaseAuth.instance;
    _databaseRef = FirebaseDatabase.instance.reference();
    _googleSignin = GoogleSignIn();
  }

  Future<bool> checkAuth() async {
    if (_auth.currentUser == null) {
      return false;
    } else {
      Utils.profileUser = await getUserData();

      return true;
    }
  }

  Future<bool> doRegistration(data) async {
    bool check = true;

    await _auth
        .createUserWithEmailAndPassword(
      email: data['email'],
      password: data['password'],
    )
        .then((value) async {
      await _databaseRef.child('users').child(value.user!.uid).set({
        'name': data['name'],
        'email': data['email'],
        'mobile': data['mobile'],
      });

      Utils.showToast('Successfully Registered. Please Login Now.');
    }).catchError((e) {
      check = false;
      Utils.showToast(e.toString());
    });

    return check;
  }

  Future<bool> doLogin(data) async {
    bool check = true;

    await _auth
        .signInWithEmailAndPassword(
      email: data['email'],
      password: data['password'],
    )
        .catchError((error) {
      check = false;
      late String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Utils.showToast(errorMessage);
    }).then((value) async {
      Utils.profileUser = await getUserData();
    });

    return check;
  }

  Future<String?> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignin.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      Utils.profileUser = await getUserData();

      return '$user';
    }

    return null;
  }

  Future<void> logout(context) async {
    if (_auth.currentUser == null) {
      await _googleSignin.signOut();
    } else {
      await _auth.signOut();
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Login()));
  }

  Future<ProfileUser> getUserData() async {
    late ProfileUser user;
    if (_auth.currentUser != null) {
      print(_auth.currentUser!.uid);

      await _databaseRef
          .child('users')
          .child(_auth.currentUser!.uid)
          .once()
          .then((value) => user = ProfileUser(
              name: value.value['name'],
              email: _auth.currentUser!.email,
              mobile: value.value['mobile'],
              type: value.value['type'],
              uid: _auth.currentUser!.uid));
    } else {
      user = ProfileUser(
          name: _googleSignin.currentUser!.displayName,
          email: _googleSignin.currentUser!.email,
          mobile: '-------',
          uid: _googleSignin.currentUser!.id);
    }

    return user;
  }

  Future<void> sendRecoverLink(email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
