import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/constants.dart';
import 'package:delivery_food/models/restaurant_model.dart';
import 'package:delivery_food/providers/restaurant_provider.dart';
import 'package:delivery_food/screens/manage_restaurants_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminRestaurantScreen extends StatelessWidget {

  Future<List<RestaurantModel>> refresh(BuildContext context) async{
   await Provider.of<RestaurantProvider>(context,listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<RestaurantProvider>(
          builder: (context, rProvider, _) =>
              FutureBuilder<List<RestaurantModel>>(
                future: refresh(context),
                builder: (context, snapshot) =>
                  snapshot.connectionState==ConnectionState.waiting?
                   Center(
                    child: CircularProgressIndicator(),
                  )
                      :
                   RefreshIndicator(
                     onRefresh:()=> refresh(context),
                     child: ListView.builder(
                      itemBuilder: (context, i) =>
                         ListTile(leading:Text(rProvider.restaurantsList[i].rank.toString()) ,
                           title: Text(rProvider.restaurantsList[i].category),
                           trailing: Container(
                             width: MediaQuery.of(context).size.width*0.3,
                           child: Row(
                             children: <Widget>[
                           IconButton(icon: Icon(Icons.edit,color: Colors.black,),onPressed: ()=>Navigator.pushNamed(context, ManageRestaurants.nameRoute,arguments: rProvider.restaurantsList[i].id)),
                           IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: ()=>rProvider.deleteRestaurant(rProvider.restaurantsList[i].id),
                           )],
                           ),
                           )),
                          itemCount: rProvider.restaurantsList.length,
                  ),
                   )
              )),
    );
  }
}
