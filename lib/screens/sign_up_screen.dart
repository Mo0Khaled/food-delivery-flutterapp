import 'package:delivery_food/models/user.dart';
import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:delivery_food/screens/admin_panel_screen.dart';
import 'package:delivery_food/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/auth/text_form.dart';

class SignupScreen extends StatefulWidget {
  static const nameRoute = "/auth_screen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Radius radius = Radius.circular(13);
  UserData userdata = UserData();
  TextEditingController _emailController = TextEditingController();
  String email = "";
  String password = "";
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          width: double.infinity,
          child: Consumer<Autheticate>(
            builder: (context, auth, _) => Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(
                        width: 100.0,
                        height: 22,
                      ),
                      Text(
                        auth.authentication == AuthenticationMode.Signup
                            ? "Sign Up"
                            : "Log In ",
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 40.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(80.0))),
                    child: SingleChildScrollView(
                      child: Form(
                        key: auth.key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            auth.authentication == AuthenticationMode.Signup
                                ? Column(
                                    children: <Widget>[
                                      CustomizedTextFormField(
                                        title: "email",
                                        neednumbersKeyboard: false,
                                        onSaved: (val) {
                                          Provider.of<Autheticate>(context,
                                                  listen: false)
                                              .userModel
                                              .email = val;
                                        },
                                        isObsecure: false,
                                      ),
                                      CustomizedTextFormField(
                                          title: "password",
                                          neednumbersKeyboard: false,
                                          onSaved: (val) {
                                            Provider.of<Autheticate>(context,
                                                    listen: false)
                                                .userModel
                                                .password = val;
                                          },
                                          isObsecure: true),
                                      CustomizedTextFormField(
                                        title: "confirm password",
                                        neednumbersKeyboard: false,
                                        isObsecure: true,
                                      ),
                                      CustomizedTextFormField(
                                        title: "User Name",
                                        neednumbersKeyboard: false,
                                        onSaved: (val) =>
                                            Provider.of<Autheticate>(context,
                                                    listen: false)
                                                .userModel
                                                .userName = val,
                                        isObsecure: false,
                                      ),
                                      CustomizedTextFormField(
                                        title: "phone Number",
                                        neednumbersKeyboard: true,
                                        onSaved: (val) =>
                                            Provider.of<Autheticate>(context,
                                                    listen: false)
                                                .userModel
                                                .phoneNumber = val,
                                        isObsecure: false,
                                      ),
                                    ],
                                  )
                                : CustomizedTextFormField(
                                    controller: _emailController,
                                    title: "email",
                                    neednumbersKeyboard: false,
                                    onSaved: (val) {
                                      setState(() {
                                        email = _emailController.text;
                                      });
                                    },
                                    isObsecure: false,
                                  ),
                            CustomizedTextFormField(
                                controller: _passwordController,
                                title: "password",
                                neednumbersKeyboard: false,
                                onSaved: (val) {
                                  setState(() {
                                    password = _passwordController.text;
                                  });
                                },
                                isObsecure: true),
                            GestureDetector(
                              onTap: () async {
                                if (auth.authentication ==
                                    AuthenticationMode.LogIn) {
                                  if (_emailController.text == "yahia" &&
                                      _passwordController.text == "shawky") {
                                    Navigator.of(context)
                                        .pushNamed(AdminPanelScreen.nameRoute);
                                  } else {
                                    await Provider.of<Autheticate>(context,
                                            listen: false)
                                        .signIn(context, _emailController.text,
                                            _passwordController.text);
                                  }
                                } else {
                                  auth.validateForm(context);
                                  Navigator.pushNamed(
                                      context, HomePage.routeId);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 300,
                                child: Text(
                                  auth.authentication ==
                                          AuthenticationMode.Signup
                                      ? "Sign up"
                                      : "Log In",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: radius,
                                        bottomLeft: radius,
                                        bottomRight: radius)),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  auth.authentication ==
                                          AuthenticationMode.Signup
                                      ? "you already have an account"
                                      : "you don't have an account",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => auth.onButtonClick(),
                                  child: Text(
                                    auth.authentication ==
                                            AuthenticationMode.Signup
                                        ? " Log in"
                                        : " Sign up",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
