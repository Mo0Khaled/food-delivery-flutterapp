import 'package:delivery_food/models/restaurant_model.dart';
import 'package:delivery_food/providers/restaurant_provider.dart';
import 'package:delivery_food/widgets/restaurant_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filtering extends StatelessWidget {
  static const routeId  = '/filtering';
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context).settings.arguments as String;
    final provider = Provider.of<RestaurantProvider>(context).filterByCategory(name);
    final pro = Provider.of<RestaurantProvider>(context);
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<RestaurantModel>>(
          future: pro.fetch(),
          builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
            itemCount: provider.length,
            itemBuilder: (context, i) => RestaurantContainerUi(
              imgUrl: provider[i].imgUrl,
              title: provider[i].restaurant,
              rank: provider[i].rank,
              desiredMeals: provider[i].desiredOrders,
              estimatedTime: provider[i].deliveryTime,
            ),
          ),
        ),
      ),
    );
  }
}
