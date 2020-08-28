import 'package:delivery_food/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/on_boarding_screen.dart';
import 'providers/authinticate_provider.dart';
import 'screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/authinticate_provider.dart';
import 'screens/home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  setUpLocator();
  runApp(FoodDelivery());
}

class FoodDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Autheticate>(
          create: (context)=>Autheticate(),
        ),
      ],
      builder:(context,_)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Food',
        theme: ThemeData(),
        home:Provider.of<Autheticate>(context,listen: true).isUserHere == true? HomePage(): OnBoardingScreen() ,
        routes: {
          SignupScreen.nameRoute:(ctx) =>SignupScreen(),
          HomePage.routeName:(ctx)=>HomePage(),
          LogIn.nameRoute:(ctx)=>LogIn()
        },
      ),
    );
  }
}

