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
    List<String> myList = ['Burger', 'Kfc', 'dwid', 'mqekjdf', 'efiofeio'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context, delegate: SearchDelegateThroughList()),
        ),
        elevation: 0,
        title: InkWell(
          onTap: () => showSearch(
              context: context, delegate: SearchDelegateThroughList()),
          child: Card(
            elevation: 2,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
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
                          boxShadow: [
                            BoxShadow.lerp(BoxShadow(color: Colors.black),
                                BoxShadow(color: Colors.black), 2)
                          ],
                          color: index == 0 ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          myList[index],
                          style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.black),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "All",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<List<RestaurantModel>>(
                future: provider.fetch(),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: provider.restaurantsList.length,
                            itemBuilder: (context, i) => RestaurantContainerUi(
                              title: provider.restaurantsList[i].restaurant,
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
    );
  }
}

class SearchDelegateThroughList extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => Navigator.of(context).pop(),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedList = query.isEmpty
        ? Provider.of<RestaurantProvider>(context, listen: false)
            .restaurantsList
        : Provider.of<RestaurantProvider>(context, listen: false)
            .restaurantsList
            .where((element) => element.restaurant.contains(query))
            .toList();
    return query.isEmpty
        ? Center(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/undraw_empty_xct9.png"),
                Text(
                  "type to get your desired restaurant!!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        : ListView.builder(
            itemCount: searchedList.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(searchedList[i].restaurant),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(searchedList[i].imgUrl),
                ),
                subtitle: Text(searchedList[i].rank.toString()),
              );
            });
  }
}
