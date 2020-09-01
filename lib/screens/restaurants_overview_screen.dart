import 'package:delivery_food/models/restaurant_model.dart';
import 'package:delivery_food/screens/filtering.dart';
import 'package:delivery_food/widgets/restaurant_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';

class RestaurantsOverview extends StatefulWidget {
  static const nameRoute = "restaurant-route";

  @override
  _RestaurantsOverviewState createState() => _RestaurantsOverviewState();
}

class _RestaurantsOverviewState extends State<RestaurantsOverview> {
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantProvider>(context);
    List<String> myList = ['drinks', 'ahmed', 'dwid', 'mqekjdf', 'efiofeio'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.04,
                child: ListView.builder(
                  itemCount: myList.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Filtering.routeId,
                              arguments: myList[index]);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            myList[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "All",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<List<RestaurantModel>>(
                  future: provider.fetch(),
                  builder: (context, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: provider.restaurantsList.length,
                          itemBuilder: (context, i) => RestaurantContainerUi(
                            title: provider.restaurantsList[i].category,
                            rank: provider.restaurantsList[i].rank,
                            imgUrl: provider.restaurantsList[i].imgUrl,
                            desiredMeals:
                                provider.restaurantsList[i].desiredOrders,
                            estimatedTime:
                                provider.restaurantsList[i].deliveryTime,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
