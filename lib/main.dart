import 'package:delivery_food/delivery_boy/map_page.dart';
import 'package:delivery_food/locator.dart';
import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:delivery_food/providers/cart_provider.dart';
import 'package:delivery_food/providers/google_maps_provider.dart';
import 'package:delivery_food/providers/order_provider.dart';
import 'package:delivery_food/providers/user_profile_provider.dart';
import 'package:delivery_food/screens/admin_panel_screen.dart';
import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/filtering.dart';
import 'package:delivery_food/screens/admin_restaurant_screen.dart';
import 'package:delivery_food/screens/google_maps_screen.dart';
import 'package:delivery_food/screens/home_page.dart';
import 'package:delivery_food/screens/manage_restaurants_screen.dart';
import 'package:delivery_food/screens/on_boarding_screen.dart';
import 'package:delivery_food/screens/order_screen.dart';
import 'package:delivery_food/screens/products_items_screen.dart';
import 'package:delivery_food/screens/login.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:delivery_food/screens/sign_up_screen.dart';
import 'package:delivery_food/providers/restaurant_provider.dart';
import 'package:delivery_food/screens/tracking_captain_screen.dart';
import 'package:delivery_food/screens/user_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/authinticate_provider.dart';
import 'screens/manage_restaurants_screen.dart';
import 'screens/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.get("userId");
  setUpLocator();
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
          create: (context) => GoogleMapsProvider(),
        ),
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
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
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
          // home:MapPage() ,
          home: home,
          routes: {
            HomePage.routeId: (context) => HomePage(),
            MangeProductsScreen.routeId: (context) => MangeProductsScreen(),
            AdminProductScreen.routeId: (context) => AdminProductScreen(),
            SignupScreen.nameRoute: (context) => SignupScreen(),
            LogIn.nameRoute: (context) => LogIn(),
            ProductsItemsScreen.routeId: (context) => ProductsItemsScreen(),
            AdminRestaurantScreen.nameRoute: (context) => AdminRestaurantScreen(),
            ManageRestaurants.routeId: (context) => ManageRestaurants(),
            AdminPanelScreen.nameRoute: (context) => AdminPanelScreen(),
            Filtering.routeId: (context) => Filtering(),
            OrderScreen.routeId: (context) => OrderScreen(),
            GoogleMapsScreen.nameRoute: (context) => GoogleMapsScreen(),
            TrackCaptainScreen.nameRoute: (context) => TrackCaptainScreen()
            // ProductDetails.routeId:(context)=>ProductDetails(),
          },
        ),
      ),
    );
  }
}
