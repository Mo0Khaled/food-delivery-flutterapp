import 'package:delivery_food/constants.dart';
import 'package:delivery_food/models/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/textform_model.dart';

class ManageRestaurants extends StatefulWidget {
  static const String routeId = "manage-rest";

  @override
  _ManageRestaurantsState createState() => _ManageRestaurantsState();
}

class _ManageRestaurantsState extends State<ManageRestaurants> {
  bool isEditing = false;
  List textFields = [];
  TextEditingController _controller = TextEditingController();
  TextForm textForm = TextForm();
  List textFormsValues = [];

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FocusNode rest = FocusNode();
  final FocusNode imgUrlNode = FocusNode();
  final FocusNode desiredMealsNode = FocusNode();
  final FocusNode deliverTimeNode = FocusNode();
  final FocusNode rankNode = FocusNode();
  final FocusNode categoryNode = FocusNode();

  Map<String, dynamic> restaurantFields = {
    'restaurant_name': "",
    kRestaurantRank: 0.toString(),
    kRestaurantDesiredOrders: "",
    kRestaurantImgUrl: "",
    kRestaurantDeliveryTime: "",
    kRestaurantCategory: "",
  };

  RestaurantModel rModel = RestaurantModel(
    id: null,
    restaurant: "",
    category: "",
    deliveryTime: "",
    desiredOrders: [],
    imgUrl: "",
    rank: 0,
  );

  // final TextEditingController _imgController = TextEditingController();

  @override
  void dispose() {
    rest.dispose();
    imgUrlNode.dispose();
    desiredMealsNode.dispose();
    deliverTimeNode.dispose();
    rankNode.dispose();
    categoryNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final restaurantId = ModalRoute.of(context).settings.arguments as String;

      if (restaurantId != null) {
        rModel =
            Provider.of<RestaurantProvider>(context).findById(restaurantId);
        restaurantFields = {
          'restaurant_name': rModel.restaurant,
          kRestaurantRank: rModel.rank.toString(),
          kRestaurantCategory: rModel.category,
          kRestaurantDeliveryTime: rModel.deliveryTime,
          kRestaurantDesiredOrders: rModel.desiredOrders,
          kRestaurantImgUrl: rModel.imgUrl,
          kRestaurantId: rModel.id
        };
        print(textFormsValues);
        isEditing = true;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void submitTheForm() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (rModel.id != null) {
        rModel = RestaurantModel(
            deliveryTime: rModel.deliveryTime,
            restaurant: rModel.restaurant,
            desiredOrders: textFormsValues,
            id: rModel.id,
            rank: rModel.rank,
            category: rModel.category,
            imgUrl: rModel.imgUrl);
        Provider.of<RestaurantProvider>(context, listen: false)
            .updateRestaurants(rModel.id, rModel);
      } else {
        rModel = RestaurantModel(
            deliveryTime: rModel.deliveryTime,
            restaurant: rModel.restaurant,
            desiredOrders: textFormsValues,
            id: rModel.id,
            rank: rModel.rank,
            category: rModel.category,
            imgUrl: rModel.imgUrl);
        Provider.of<RestaurantProvider>(context, listen: false)
            .addRestaurant(rModel, context);
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("something went wrong"),
      ));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add a restaurants"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              submitTheForm();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  initialValue: restaurantFields['restaurant_name'],
                  validator: (val) {
                    if (val.isEmpty) {
                      return "check your inputs please";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    rModel = RestaurantModel(
                      restaurant: val,
                      category: rModel.category,
                      id: rModel.id,
                      deliveryTime: rModel.deliveryTime,
                      desiredOrders: rModel.desiredOrders,
                      imgUrl: rModel.imgUrl,
                      rank: rModel.rank,
                    );
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(categoryNode);
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: rest,
                  decoration: InputDecoration(labelText: "Restaurant Name"),
                ),
                TextFormField(
                  initialValue: restaurantFields[kRestaurantCategory],
                  validator: (val) {
                    if (val.isEmpty || val.length < 2) {
                      return "check your inputs please";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    rModel = RestaurantModel(
                        restaurant: rModel.restaurant,
                        category: val,
                        id: rModel.id,
                        deliveryTime: rModel.deliveryTime,
                        desiredOrders: rModel.desiredOrders,
                        imgUrl: rModel.imgUrl,
                        rank: rModel.rank);
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(deliverTimeNode);
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: categoryNode,
                  decoration: InputDecoration(labelText: kRestaurantCategory),
                ),
                TextFormField(
                  initialValue: restaurantFields[kRestaurantDeliveryTime],
                  onSaved: (val) {
                    rModel = RestaurantModel(
                        restaurant: rModel.restaurant,
                        deliveryTime: val,
                        rank: rModel.rank,
                        imgUrl: rModel.imgUrl,
                        desiredOrders: rModel.desiredOrders,
                        id: rModel.id,
                        category: rModel.category);
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(desiredMealsNode);
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "the field should not be empty";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: deliverTimeNode,
                  decoration:
                      InputDecoration(labelText: kRestaurantDeliveryTime),
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  initialValue: restaurantFields[kRestaurantRank].toString(),
                  onSaved: (val) {
                    rModel = RestaurantModel(
                        restaurant: rModel.restaurant,
                        rank: double.parse(val),
                        category: rModel.category,
                        id: rModel.id,
                        desiredOrders: rModel.desiredOrders,
                        imgUrl: rModel.imgUrl,
                        deliveryTime: rModel.deliveryTime);
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(imgUrlNode);
                  },
                  focusNode: imgUrlNode,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: kRestaurantRank),
                ),
                TextFormField(
                  initialValue: restaurantFields[kRestaurantImgUrl],
                  validator: (val) {
                    if (val.isEmpty ||
                        !val.contains("http") ||
                        !val.contains("https")) {
                      return "check if your input if it's empty,or not obeying the right format for a url.";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    rModel = RestaurantModel(
                        restaurant: rModel.restaurant,
                        rank: rModel.rank,
                        category: rModel.category,
                        id: rModel.id,
                        desiredOrders: rModel.desiredOrders,
                        imgUrl: val,
                        deliveryTime: rModel.deliveryTime);
                  },
                  onFieldSubmitted: (_) {
                    submitTheForm();
                  },
                  focusNode: rankNode,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: kRestaurantImgUrl),
                ),
                isEditing
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Desired Meals",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                              ),
                              RaisedButton(
                                color: Colors.black,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isEditing = false;
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(6)),
                              width: double.infinity,
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    restaurantFields[kRestaurantDesiredOrders]
                                        .length,
                                itemBuilder: (context, i) => Container(
                                    width: 60,
                                    height: 10,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                    margin: const EdgeInsets.all(10),
                                    child: Text(
                                      restaurantFields[kRestaurantDesiredOrders]
                                          [i],
                                      style: TextStyle(color: Colors.black),
                                    )
                                ),
                              )
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                if(textFields.length==0){
                                  textFields.add(TextFormField());
                                }
                              });
                            },
                            child: Text(
                              "add the desired meals",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: ListView.builder(
                                itemCount:textFields.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: <Widget>[
                                      TextFormField(
                                        onChanged: (val) {
                                          setState(() {
                                            textForm.value = val;
                                          });
                                        },
                                        controller: _controller,
                                      ),
                                      FlatButton(
                                          child: Text("add it"),
                                          onPressed: () {
                                            setState(() {
                                              textFormsValues
                                                  .add(textForm.value);
                                              _controller.clear();
                                            });
                                          }),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.black),
                                        width: double.infinity,
                                        height: 50,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: textFormsValues.length,
                                            itemBuilder: (context, i) {
                                              return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: Colors.white),
                                                  width: 50,
                                                  height: 10,
                                                  child: Text(
                                                    textFormsValues[i],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ));
                                            }),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
