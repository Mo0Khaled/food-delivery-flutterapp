import 'package:delivery_food/locator.dart';
import 'package:delivery_food/providers/restaurant_provider.dart';
import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/restaurants_overview_screen.dart';
import 'package:delivery_food/screens/manage_restaurants_screen.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/authinticate_provider.dart';
import 'screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget home = RestaurantsOverview();
  if (FirebaseAuth.instance.currentUser.uid == null) {
    home = SignupScreen();
  }

//  setUpLocator();
  runApp(FoodDelivery(home));
}

class FoodDelivery extends StatelessWidget {
  Widget home;
  FoodDelivery(this.home);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => locator<ProductProvider>(),
          ),
          ChangeNotifierProvider(
            create: (context) => Autheticate(),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantProvider(),
          )
        ],
        builder: (context, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Food',
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    color: Colors.white,
                    elevation: 10,
                    textTheme: TextTheme(
                      caption: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    iconTheme: IconThemeData(color: Colors.black),
                  ),
                ),
                // home: HomePage(),
                home: home,
                routes: {
                  MangeProductsScreen.routeId: (context) =>
                      MangeProductsScreen(),
                  AdminProductScreen.routeId: (context) => AdminProductScreen(),
                  ManageRestaurants.nameRoute: (context) => ManageRestaurants(),
                  SignupScreen.nameRoute: (context) => SignupScreen()
                }));
  }
}
//AdminProductScreen.routeId
