import 'package:delivery_food/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'dart:io';

class UserProfileProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  UserData user = UserData();
  File image;

  fetchUserData() async {
    try {
      var uId = _auth.currentUser.uid;
      await _store.collection(kUsersCollection).doc(uId).get().then((doc) {
        user = UserData(
            email: doc.data()[kUserEmail],
            phoneNumber: doc.data()[kUserPhoneNumber],
            userName: doc.data()[kUserName]);
        return user;
      });
    } catch (e) {
      print(e);
    }
  }
}
