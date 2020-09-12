import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MangeProductsScreen extends StatefulWidget {
  static const routeId = '/manging';

  @override
  _MangeProductsScreenState createState() => _MangeProductsScreenState();
}

class _MangeProductsScreenState extends State<MangeProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFoucsNode = FocusNode();
  final _caloriesFocusNode = FocusNode();
  final _categoryNameFocusNode = FocusNode();
  final _restaurantFoucsNode = FocusNode();
  final _imgFoucsNode = FocusNode();
  final _imgController = TextEditingController();
  var _makeProducts = ProductModel(
    id: null,
    title: '',
    price: 0,
    description: '',
    calories: 0,
    imgUrl: '',
    categoryName: '',
    restaurantName: '',
  );
  var _initValue = {
    'title': '',
    'price': '',
    'description': '',
    'calories': '',
    'imgUrl': '',
    'categoryName': '',
    'restaurantName': '',
  };
  var _isInit = true;
  @override
  void initState() {
    _imgFoucsNode.addListener(_upDateImageUrl);
    Provider.of<ProductProvider>(context,listen: false);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _makeProducts = Provider.of<ProductProvider>(context).findById(productId);
         _initValue = {
          'title': _makeProducts.title,
          'price': _makeProducts.price.toString(),
          'description': _makeProducts.description,
          'calories': _makeProducts.calories.toString(),
          'imgUrl': '',
          'categoryName': _makeProducts.categoryName,
          'restaurantName': _makeProducts.restaurantName,
        };
      _imgController.text = _makeProducts.imgUrl;
      }
    _isInit = false;
    }
    super.didChangeDependencies();
  }
  void _upDateImageUrl() {
    if (!_imgFoucsNode.hasFocus) {
      if ((!_imgController.text.startsWith("http") &&
          !_imgController.text.startsWith("https")) ||
          (!_imgController.text.endsWith("png") &&
              !_imgController.text.endsWith("jpg") &&
              !_imgController.text.endsWith("jpeg"))) {
        return;
      }
      setState(() {});
    }
  }
  @override
  void dispose() {
    _categoryNameFocusNode.dispose();
    _caloriesFocusNode.dispose();
    _priceFocusNode.dispose();
    _imgController.dispose();
    _imgFoucsNode.dispose();
    _restaurantFoucsNode.dispose();
    _descriptionFoucsNode.dispose();
    super.dispose();
  }

  void _saveForm(){
    final isValid = _formKey.currentState.validate();
    if(!isValid){
      return;
    }
    _formKey.currentState.save();
    if(_makeProducts.id != null){
      Provider.of<ProductProvider>(context,listen: false).updateProduct(_makeProducts, _makeProducts.id);
    }else{
      Provider.of<ProductProvider>(context,listen: false).addProduct(_makeProducts);
    }
    Navigator.of(context).pop();
  }
  String initialValCategory = "burgers";
  String initialValRes = "mac";
  @override
  Widget build(BuildContext context) {
    final categoryPro = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () =>_saveForm(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(
                    hintText: "Product Title", border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a product title";
                  } else if (val.length < 4) {
                    return "Please Enter a word bigger than it";
                  }
                  return null;
                },
                onSaved: (exValue) {
                  _makeProducts = ProductModel(
                    id: _makeProducts.id,
                    title: exValue,
                    price: _makeProducts.price,
                    description: _makeProducts.description,
                    calories: _makeProducts.calories,
                    imgUrl: _makeProducts.imgUrl,
                    categoryName: _makeProducts.categoryName,
                    restaurantName: _makeProducts.restaurantName,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Product Price", border: OutlineInputBorder()),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_caloriesFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter The product Price";
                  }
                  return null;
                },
                onSaved: (exValue) {
                  _makeProducts = ProductModel(
                    id: _makeProducts.id,
                    title: _makeProducts.title,
                    price: double.parse(exValue),
                    description: _makeProducts.description,
                    calories: _makeProducts.calories,
                    imgUrl: _makeProducts.imgUrl,
                    categoryName: _makeProducts.categoryName,
                    restaurantName: _makeProducts.restaurantName,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['calories'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Product Calories", border: OutlineInputBorder()),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_categoryNameFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Product Calories";
                  }
                  return null;
                },
                onSaved: (exValue) {
                  _makeProducts = ProductModel(
                    id: _makeProducts.id,
                    title: _makeProducts.title,
                    price: _makeProducts.price,
                    description: _makeProducts.description,
                    calories: double.parse(exValue),
                    imgUrl: _makeProducts.imgUrl,
                    categoryName: _makeProducts.categoryName,
                    restaurantName: _makeProducts.restaurantName,
                  );
                },
              ),

              FutureBuilder(
                future: categoryPro.fetchCategories(),
                builder:(context,snapshot){
                    // initialVal = categoryPro.category.first;
                  return DropdownButton<String>(
                    value: initialValCategory == "" ? initialValCategory = categoryPro.category.first: initialValCategory,
                    items: categoryPro.category.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        initialValCategory = newValue;
                        _makeProducts = ProductModel(
                          id: _makeProducts.id,
                          title: _makeProducts.title,
                          price: _makeProducts.price,
                          description: _makeProducts.description,
                          calories: _makeProducts.calories,
                          imgUrl: _makeProducts.imgUrl,
                          categoryName: initialValCategory,
                          restaurantName: _makeProducts.restaurantName,
                        );
                      });
                    },
                  );
                }
              ),

              FutureBuilder(
                  future: categoryPro.fetchRestaurant(),
                  builder:(context,snapshot){
                    // initialVal = categoryPro.category.first;
                    return DropdownButton<String>(
                      value: initialValRes == "" ? initialValRes = categoryPro.restaurant.first: initialValRes,
                      items: categoryPro.restaurant.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          initialValRes = newValue;
                          _makeProducts = ProductModel(
                            id: _makeProducts.id,
                            title: _makeProducts.title,
                            price: _makeProducts.price,
                            description: _makeProducts.description,
                            calories: _makeProducts.calories,
                            imgUrl: _makeProducts.imgUrl,
                            categoryName: _makeProducts.categoryName,
                            restaurantName: initialValRes,
                          );
                        });
                      },
                    );
                  }
              ),



              // TextFormField(
              //   initialValue: _initValue['restaurantName'],
              //   textInputAction: TextInputAction.next,
              //   decoration: InputDecoration(
              //       hintText: "Restaurant Name", border: OutlineInputBorder()),
              //   onFieldSubmitted: (_) {
              //     FocusScope.of(context).requestFocus(_descriptionFoucsNode);
              //   },
              //   validator: (val) {
              //     if (val.isEmpty) {
              //       return "Please Enter a Restaurant Name";
              //     }
              //     return null;
              //   },
              //   onSaved: (exValue) {
              //     _makeProducts = ProductModel(
              //       id: _makeProducts.id,
              //       title: _makeProducts.title,
              //       price: _makeProducts.price,
              //       description: _makeProducts.description,
              //       calories:_makeProducts.calories,
              //       imgUrl: _makeProducts.imgUrl,
              //       categoryName: _makeProducts.categoryName,
              //       restaurantName: exValue,
              //     );
              //   },
              // ),
              TextFormField(
                initialValue: _initValue['description'],
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "Description", border: OutlineInputBorder()),
                focusNode: _descriptionFoucsNode,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Description";
                  }
                  if(val.length < 10){
                    return "should be at least 10 char";
                  }
                  return null;
                },
                onSaved: (exValue) {
                  _makeProducts = ProductModel(
                    id: _makeProducts.id,
                    title: _makeProducts.title,
                    price: _makeProducts.price,
                    description: exValue,
                    calories:_makeProducts.calories,
                    imgUrl: _makeProducts.imgUrl,
                    categoryName: _makeProducts.categoryName,
                    restaurantName: _makeProducts.restaurantName,
                  );
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(labelText: "Img Url",border: OutlineInputBorder()),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imgController,
                focusNode: _imgFoucsNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a ImgUrl";
                  }
                  if (!val.startsWith("http") &&
                      !val.startsWith("https")) {
                    return "Please Enter Valid Url";
                  }
                  if (!val.endsWith("png") &&
                      !val.endsWith("jpg") &&
                      !val.endsWith("jpeg")) {
                    return "Enter a Valid img";
                  }
                  return null;
                },
                onSaved: (exValue) {
                  _makeProducts = ProductModel(
                    id: _makeProducts.id,
                    title: _makeProducts.title,
                    price: _makeProducts.price,
                    description: _makeProducts.description,
                    calories:_makeProducts.calories,
                    imgUrl: exValue,
                    categoryName: _makeProducts.categoryName,
                    restaurantName: _makeProducts.restaurantName,
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: _imgController.text.isEmpty
                    ? Text("Enter a Url")
                    : Image.network(
                      _imgController.text,
                      fit: BoxFit.contain,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
