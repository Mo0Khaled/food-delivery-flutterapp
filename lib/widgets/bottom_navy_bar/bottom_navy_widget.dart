import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavyBarWidget extends StatelessWidget {
  final int index;
  final Function changeItem;

  BottomNavyBarWidget({
    @required this.index,
    @required this.changeItem,
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor = Color(0xFFffb218);
    Color inactiveColor = Colors.black;
    TextStyle navyTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
    );
    return BottomNavyBar(
      selectedIndex: index,
      onItemSelected: changeItem,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          activeColor: activeColor,
            inactiveColor: inactiveColor,
            title: Text('Home',style: navyTextStyle,textAlign: TextAlign.center,),
            icon: Icon(FontAwesomeIcons.home)
        ),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            title: Text('Payment',style: navyTextStyle,textAlign: TextAlign.center,),
            icon: Icon(FontAwesomeIcons.percent)
        ),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            title: Text('Cart',style: navyTextStyle,textAlign: TextAlign.center,),
            icon: Icon(FontAwesomeIcons.shoppingBasket)
        ),
        BottomNavyBarItem(
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            title: Text('Profile',style: navyTextStyle,textAlign: TextAlign.center,),
            icon: Icon(FontAwesomeIcons.user)
        ),
      ],
    );
  }
}
