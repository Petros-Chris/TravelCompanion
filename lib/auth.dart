import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';
import 'login.dart';

class Auth {
  void signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String message = 'Registered Successfully';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()));

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        message = 'Weak Password';
      } else if (error.code == 'email-already-in-use') {
        message = 'Email Already In Use';
      }
    } catch (error) {
      message = 'Something Went Wrong!';
    }
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String message = 'Logged In Successfully';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        message = 'No Accounts Associated With Email';
      } else if (error.code == 'wrong-password') {
        message = 'Invalid Password';
      }
    } catch (error) {
      message = 'Something Went Wrong!';
    }
  }

  void logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
  }

  void signInWithGoogle({required BuildContext context}) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (user.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }

    print(user.user?.displayName);
  }
}
