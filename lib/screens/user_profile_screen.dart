import 'package:delivery_food/providers/authinticate_provider.dart';
import 'package:delivery_food/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../db_sqlite/db.dart';
import '../models/image_sqlite.dart';
import 'order_screen.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String imageF;
  ImageSqlite image = ImageSqlite();
  DBSqlite db = DBSqlite();
  Map images;

  @override
  void initState() {
    super.initState();
    returnPicture();
  }

  Future<void> returnPicture() async {
    image = await db
        .getPhoto(FirebaseAuth.instance.currentUser.uid.substring(0, 2));
    print("${image.imageName} hhh");
    setState(() {
      imageF = image.imageName;
    });
  }

  void picture(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.getImage(source: ImageSource.gallery);
    try {
      ImageSqlite imagesql = ImageSqlite(
        id: FirebaseAuth.instance.currentUser.uid.substring(0, 2),
        imageName: imageFile.path,
      );
      setState(() {
        imageF = imageFile.path;
      });
      db.savePhoto(imagesql);
      Navigator.pop(context);
    } catch (error) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("You did\'t picked any Image!")));
      Navigator.pop(context);
    }
  }

  void capture(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    var imageFile = await imagePicker.getImage(source: ImageSource.camera);
    try {
      ImageSqlite imagesql = ImageSqlite(
          id: FirebaseAuth.instance.currentUser.uid.substring(0, 2),
          imageName: imageFile.path);
      setState(() {
        imageF = imageFile.path;
      });
      db.updateImage(imagesql);
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
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
                  onPressed: () {
                    picture(context);
                  },
                ),
                FlatButton(
                  child: Text("capture image"),
                  onPressed: () => capture(context),
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
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () async {
                await Provider.of<Autheticate>(context, listen: false)
                    .signout(context);
                Navigator.of(context)
                    .pushReplacementNamed(SignupScreen.nameRoute);
              })
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
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                child: CircleAvatar(
                                  backgroundImage: imageF == null
                                      ? AssetImage("assets/images/no-user.jpg")
                                      : AssetImage(imageF),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.2,
                                top: MediaQuery.of(context).size.height * 0.1,
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                            myListTile(
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
                            myListTile("Cards", null, FontAwesomeIcons.simCard,
                                Color(0xFFffb218), Colors.yellow[100], () {}),
                            SizedBox(
                              height: 10,
                            ),
                            myListTile(
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

Widget myListTile(String title, Function ontap, IconData icondata, Color color,
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
