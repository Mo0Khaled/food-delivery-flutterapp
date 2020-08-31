import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:delivery_food/screens/on_boarding_screen.dart';
import 'package:delivery_food/screens/products_items_screen.dart';
import 'package:delivery_food/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_navy_bar/bottom_navy_widget.dart';
class HomePage extends StatefulWidget {
  static const  routeId ="home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex  = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  changePage(int index){
    setState(() => currentIndex = index);
  }

  changeItem(int index){
    setState(() => currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: changePage,
        children: [
          ProductsItemsScreen(),
          Scaffold(appBar: AppBar(),),
          Scaffold(appBar: AppBar(),),
          UserProfile()
        ],
      ),
      bottomNavigationBar: BottomNavyBarWidget(index: currentIndex,changeItem: changeItem,),
    );
  }
}