import 'dart:convert';

import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import '../providers/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../db_sqlite/db.dart';
import '../models/image_sqlite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'order_screen.dart';
import '../models/image_sqlite.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File imageName;
  ImagaSqlite image;
  var decodedImage;
  DBSqlite db;
  Map images;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = ImagaSqlite();
    db = DBSqlite();
    returnPicture();
  }

  Future<void> returnPicture() async {
    image = await db
        .getPhoto(FirebaseAuth.instance.currentUser.uid.substring(0, 2));
    setState(() {
      decodedImage = base64Decode(image.imageName);
    });
  }

  void picture(BuildContext context) async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    String imgString = base64Encode(imageFile.readAsBytesSync());
    ImagaSqlite imagesql = ImagaSqlite(
        id: FirebaseAuth.instance.currentUser.uid.substring(0, 2),
        imageName: imgString);
    setState(() {
      imageName = imageFile;
    });
    db.savePhoto(imagesql);
    Navigator.pop(context);
  }

  void onButtonClickTap(BuildContext context) {
    showDialog(
        context: context,
        child: AlertDialog(
          content: Text("choose option plesae"),
          actions: <Widget>[
            Column(
              children: <Widget>[
                FlatButton(
                  child: Text("pick image"),
                  onPressed: () => picture(context),
                ),
                FlatButton(
                  child: Text("capture image"),
                  onPressed: () => null,
                ),
                FlatButton(
                  child: Text("cancel"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.ellipsisV),
            onPressed: () => Provider.of<Autheticate>(context, listen: false)
                .signout(context),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserProfileProvider>(context, listen: false)
            .fetchUserData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            onButtonClickTap(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: CircleAvatar(
                                  backgroundImage: image.imageName != null
                                      ? AssetImage("assets/images/no-user.jpg")
                                      :MemoryImage(decodedImage),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.2,
                                top: MediaQuery.of(context).size.width * 0.25,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    color: Colors.white,
                                  ),
                                  child: IconButton(
                                    onPressed: () => onButtonClickTap(context),
                                    icon: (Icon(
                                      Icons.add_a_photo,
                                      size: 25,
                                      color: Colors.black,
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                            "${Provider.of<UserProfileProvider>(context, listen: false).user.userName}"),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 3),
                            child: Text(
                              "Lvl 12",
                              style: TextStyle(
                                  color: Color(0xFFffb218), fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "70%",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Color(0xFFFFB41E),
                                  width: 7,
                                )),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Macdonalds",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                                width: 20,
                              ),
                              Text("25% discount on all products")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            MylistTile(
                                "Orders",
                                null,
                                Icons.border_all,
                                Colors.purpleAccent[50],
                                Colors.purpleAccent, () {
                              Navigator.of(context)
                                  .pushNamed(OrderScreen.routeId);
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            MylistTile("Cards", null, FontAwesomeIcons.simCard,
                                Color(0xFFffb218), Colors.yellow[100], () {}),
                            SizedBox(
                              height: 10,
                            ),
                            MylistTile(
                                "Location",
                                null,
                                Icons.location_on,
                                Colors.lightBlueAccent,
                                Colors.cyan[100],
                                () {}),
                          ],
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

Widget MylistTile(String title, Function ontap, IconData icondata, Color color,
    iconColor, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      title: Text(title),
      onTap: ontap,
      leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
          child: Icon(
            icondata,
            color: iconColor,
            size: 30,
          )),
    ),
  );
}
