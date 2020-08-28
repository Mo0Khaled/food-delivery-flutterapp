import 'package:delivery_food/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authinticate_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  static const String  nameRoute="log-in";
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "";
  String password = "";
  final _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _form=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: _form ,
                child: Column(
                  children: <Widget>[
                   TextFormField(

                     onSaved: (_){
                       setState(() {
                         email=_emailController.text;
                       });
                     },
                     controller: _emailController,
                     decoration: InputDecoration(
                       labelText: "email"
                     ),
                   ),
                    TextFormField(
                      controller: _passwordController,
                      onSaved: (val){
                       setState(() {
                         password=_passwordController.text;
                       });
                      },
                      decoration: InputDecoration(
                          labelText: "password"
                      ),
                    ),
                    FlatButton(
                      color: Colors.black,
                      onPressed: ()async{
                       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                       Navigator.of(context).pushNamed(HomePage.routeName);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
