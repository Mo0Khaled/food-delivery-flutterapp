import 'package:delivery_food/screens/products_items_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user.dart';
enum AuthenticationMode{
  Signup,
  LogIn
}
class Autheticate with ChangeNotifier{

  bool isObsecure=true;
  AuthenticationMode authentication=AuthenticationMode.LogIn;
  GlobalKey<FormState> key=GlobalKey<FormState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _store =FirebaseFirestore.instance;
  bool isUserHere=false;
  String password,email;

  UserData userModel = UserData();

void handleObsecure(){
   if(isObsecure==false){
     isObsecure=true;
   }
   else{
     isObsecure=false;
   }
   notifyListeners();
}

  void onButtonClick(){
    if(authentication==AuthenticationMode.Signup){
      authentication=AuthenticationMode.LogIn;
    }
    else{
      authentication=AuthenticationMode.Signup;
    }
    notifyListeners();
  }
   void controlUser()async{
  try{
    var currnetUserTokeId = _auth.currentUser.uid;
    if(currnetUserTokeId !=null){
      isUserHere=true;
      notifyListeners();
    }
  }catch(error){
    print("error is $error");
  }

   }
  void validateForm(BuildContext context)async{
    if(key.currentState.validate()){
      key.currentState.save();
      await signUp(context);
      controlUser();
      addUserDataToDataBase();
    }
    notifyListeners();
  }
  void signUp(BuildContext context) async{
  try{
    var user=await _auth.createUserWithEmailAndPassword(email:userModel.email, password: userModel.password);

  }catch(error){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("revise your inputs,please!"),
    ));
  }
  }
  void addUserDataToDataBase(){
    var currentUser=_auth.currentUser.uid;
    _store.collection(kUsersCollection).doc(currentUser).set({
      kUserName:userModel.userName,
      kEmail:userModel.email,
      kPhoneNumber:userModel.phoneNumber
    });
    notifyListeners();
  }
  signIn(BuildContext context,email,password) async {
  try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
    if(_auth.currentUser.uid != null){
      Navigator.of(context).pushNamed(ProductsItemsScreen.routeId);
    }
  }catch(error){
    print(error);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("revise your inputs,please!"),
    ));
  }
 }
}