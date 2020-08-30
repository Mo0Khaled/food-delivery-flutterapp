import 'package:delivery_food/models/restaurant_model.dart';
import 'package:delivery_food/widgets/restaurant_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';

class RestaurantsOverview extends StatelessWidget {
  // ignore: missing_return
  Future<List<RestaurantModel>> refresh(BuildContext context) async {
    await Provider.of<RestaurantProvider>(context, listen: false).fetch();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RestaurantProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () => refresh(context),
          child: FutureBuilder<List<RestaurantModel>>(
            future: refresh(context),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, i) => RestaurantContainerUi(
                            title: provider.restaurantsList[i].category,
                            rank: provider.restaurantsList[i].rank)),
          ),
        ),
      ),
    );
  }
}
