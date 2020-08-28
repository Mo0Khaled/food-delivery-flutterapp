
import 'package:delivery_food/locator.dart';
import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();

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
        ChangeNotifierProvider(
          create: (context) => locator<ProductProvider>(),
        ),

      ],
      child: MaterialApp(
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
        initialRoute: AdminProductScreen.routeId,
        routes: {
         MangeProductsScreen.routeId: (context) => MangeProductsScreen(),
           AdminProductScreen.routeId:(context) =>AdminProductScreen(),
          }

      )
    );
  }
}
