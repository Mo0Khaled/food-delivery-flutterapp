import 'package:delivery_food/locator.dart';
import 'package:delivery_food/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
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
        title: 'Flutter Food',
        theme: ThemeData(),
        home: HomePage(),
      ),
    );
  }
}
