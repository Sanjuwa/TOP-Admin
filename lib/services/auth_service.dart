import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:top_admin/models/user_model.dart';
import 'package:top_admin/widgets/toast.dart';

class AuthService {

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user){
    if (user == null){
      return null;
    }

    return User(user.uid, user.email);
  }

  Future<User?> get currentUser async {
    try{
      await _auth.currentUser?.reload();
    }
    catch (e) {
      ToastBar(text: e.toString(), color: Colors.red).show();
      signOut();
    }

    await _auth.currentUser?.reload();
    return _userFromFirebase(_auth.currentUser);
  }

  Future<bool> signOut() async {
    try{
      await _auth.signOut();
      return true;
    }
    catch(e){
      ToastBar(text: e.toString(), color: Colors.red).show();
      return false;
    }
  }

  Future<User?>? signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return _userFromFirebase(credential.user);

    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastBar(text: 'No user found for that email.', color: Colors.red).show();
      } else if (e.code == 'wrong-password') {
        ToastBar(text: 'Wrong password provided for that user.', color: Colors.red).show();
      } else if (e.code == 'invalid-email') {
        ToastBar(text: 'Email is invalid.', color: Colors.red).show();
      }
    }
    catch (e){
      ToastBar(text: e.toString(), color: Colors.red).show();
    }

    return null;
  }
}