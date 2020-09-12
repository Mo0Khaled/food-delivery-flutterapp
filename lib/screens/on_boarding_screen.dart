import 'package:delivery_food/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/auth/on-boarding.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      singlePage(
          "Food Delivery",
          "assets/images/pic1.png",
          "the delivery man will deliver you the order on time,if the courier is late you will get the refund",
          context),
      singlePage(
          "Communication",
          "assets/images/pic1.png",
          "During food delivery,you can communicate with the deliveryman with some kind of request",
          context),
      singlePage(
          "Food Delivery",
          "assets/images/pic1.png",
          "the delivery man will deliver you the order on time,if the courier is late you will get the refund",
          context),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  itemBuilder: (context, index) => pages[index],
                  itemCount: pages.length,
                  onPageChanged: (pageIndex) {
                    setState(() {
                      _pageIndex = pageIndex;
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.022,
              ),
              DotsIndicator(
                dotsCount: pages.length,
                mainAxisAlignment: MainAxisAlignment.center,
                position: _pageIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.022,
              ),
              Column(
                children: <Widget>[
                  button(context, Colors.black, "Log In", () {
                    Navigator.of(context).pushNamed(SignupScreen.nameRoute);
                  }, true),
                  SizedBox(
                    height: 20.0,
                  ),
                  button(context, Colors.white, "Sign up", () {
                    Navigator.of(context).pushNamed(SignupScreen.nameRoute);
                  }, false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
