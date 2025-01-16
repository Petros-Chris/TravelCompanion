import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';
import 'login.dart';

class Auth {
  void signup(
      {required String email,
      required String name,
      required String password,
      required BuildContext context}) async {
    String message = 'Registered Successfully';
    try {
      if (name.isEmpty) {
        throw 'name-empty';
      }
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = user.user!.uid;

      await FirebaseFirestore.instance.collection('userProfile').doc(uid).set({
        'name': name,
        'email': email,
        'uid': uid,
      });

      if (!context.mounted) return;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'weak-password':
          message = 'Weak Password';
          break;
        case 'email-already-in-use':
          message = 'Email Already In Use';
          break;
        case 'invalid-email':
          message = 'The Email Does Not Exist';
          break;
      }
    } catch (error) {
      switch (error) {
        case 'name-empty':
          message = 'All Fields Must Be Filled';
      }
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String message = 'Please Enter Email And Password';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // If it gets here, the user likely logged in
      message = 'Logged In Successfully';

      if (!context.mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-disabled':
          message = 'This Account Has Been Disabled';
          break;
        case 'wrong-password':
          message = 'Invalid Password';
          break;
        case 'invalid-email':
          message = 'The Email Does Not Exist';
          break;
      }
    } catch (error) {
      message = 'Something Went Wrong';
    }
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void logout({required BuildContext context}) async {
    String message = '';
    try {
      await FirebaseAuth.instance.signOut();
      message = 'Logged Out Successfully';
    } catch (error) {
      message = 'Failed To Log User Out, Please Try Again';
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    if (!context.mounted) return;
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

    String uid = user.user!.uid;
    String? name = user.user?.displayName;
    String? email = user.user?.email;

    await FirebaseFirestore.instance.collection('userProfile').doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
    });

    if (user.user != null) {
      if (!context.mounted) return;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
