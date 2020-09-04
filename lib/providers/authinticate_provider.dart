import 'package:delivery_food/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationMode { Signup, LogIn }

class Autheticate with ChangeNotifier {
  bool isObsecure = true;
  AuthenticationMode authentication = AuthenticationMode.LogIn;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _store = FirebaseFirestore.instance;
  bool isUserHere = true;

  UserData userModel = UserData();

  void handleObsecure() {
    if (isObsecure == false) {
      isObsecure = true;
    } else {
      isObsecure = false;
    }
    notifyListeners();
  }

  void onButtonClick() {
    if (authentication == AuthenticationMode.Signup) {
      authentication = AuthenticationMode.LogIn;
    } else {
      authentication = AuthenticationMode.Signup;
    }
    notifyListeners();
  }


  Future validateForm(BuildContext context) async {
    if (key.currentState.validate()) {
      key.currentState.save();
       signUp(context);
      saveUserIdInSharedPreference();
      addUserDataToDataBase();
    }
    notifyListeners();
  }

  void signUp(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      saveUserIdInSharedPreference();
    } catch (error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("revise your inputs,please!"),
      ));
    }
  }

  void addUserDataToDataBase() {
    var currentUser = _auth.currentUser.uid;
    _store.collection(kUsersCollection).doc(currentUser).set({
      kUserName: userModel.userName,
      kUserEmail: userModel.email,
      kUserPhoneNumber: userModel.phoneNumber
    });
    notifyListeners();
  }

  signIn(BuildContext context, email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      saveUserIdInSharedPreference();
      Navigator.of(context).pushReplacementNamed(HomePage.routeId);
      notifyListeners();
    } catch (error) {
      print(error);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("revise your inputs,please!"),
        ),
      );
    }
  }

  void saveUserIdInSharedPreference() async {
    var userId = _auth.currentUser.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  Future<void> signout(BuildContext context)async{
    try {
      await _auth.signOut();
      notifyListeners();
    }catch(e){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("you can't log out"),
      ));
    }

}

}
