import 'package:delivery_food/locator.dart';
import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:delivery_food/providers/user_profile_provider.dart';
import 'package:delivery_food/screens/admin_panel_screen.dart';
import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/admin_restaurant_screen.dart';
import 'package:delivery_food/screens/home_page.dart';
import 'package:delivery_food/screens/manage_restaurants_screen.dart';
import 'package:delivery_food/screens/on_boarding_screen.dart';
import 'package:delivery_food/screens/products_items_screen.dart';
import 'package:delivery_food/screens/login.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:delivery_food/screens/sign_up_screen.dart';
import 'package:delivery_food/providers/restaurant_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/authinticate_provider.dart';
import 'screens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.get("userId");

  runApp(FoodDelivery(userId == null ? OnBoardingScreen() : HomePage()));
}

class FoodDelivery extends StatelessWidget {
  final Widget home;
  FoodDelivery(this.home);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => locator<ProductProvider>(),
        ),
        ChangeNotifierProvider<Autheticate>(
          create: (context) => Autheticate(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileProvider(),
        )
      ],
      child: Consumer<Autheticate>(
        builder: (context, auth, _) => MaterialApp(
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
          // home: auth.isUserHere ? ProductsItemsScreen() :OnBoardingScreen(),
          home: home,
          routes: {
            HomePage.routeId: (context) => HomePage(),
            MangeProductsScreen.routeId: (context) => MangeProductsScreen(),
            AdminProductScreen.routeId: (context) => AdminProductScreen(),
            SignupScreen.nameRoute: (context) => SignupScreen(),
            LogIn.nameRoute: (context) => LogIn(),
            ProductsItemsScreen.routeId: (context) => ProductsItemsScreen(),
            AdminRestaurantScreen.nameRoute: (context) => AdminRestaurantScreen(),
            ManageRestaurants.nameRoute: (context) => ManageRestaurants(),
            AdminPanelScreen.nameRoute: (context) => AdminPanelScreen()
            // ProductDetails.routeId:(context)=>ProductDetails(),
          },
        ),
      ),
    );
  }
}
