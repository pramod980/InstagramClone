import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Resources/storagr_method.dart';
import 'package:instagram_clone/utilities/utils.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signup users
  Future<String> signUpUsers({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //Register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //print(cred.user!.uid);

        String profileurl = await StorageMethod()
            .uploadImageToStorage("ProfilePics", file, false);

        //Store user data into database
        await _firestore.collection('User').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'password': password,
          'bio': bio,
          'followers': [],
          'following': [],
          'profile': profileurl,
        });
        res = "Success";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //Authenticating login users

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
