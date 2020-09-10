import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../providers/google_maps_provider.dart';

class TrackCaptainScreen extends StatefulWidget {
  static const String nameRoute = "/captain-screen";
  @override
  _TrackCaptainScreenState createState() => _TrackCaptainScreenState();
}

class _TrackCaptainScreenState extends State<TrackCaptainScreen> {
  FirebaseFirestore _store = FirebaseFirestore.instance;
  var initPosition;
  List<Polyline> polylines = [];
  LatLng destinationPosition;

  @override
  void initState() {
    getCoordinatesOfCaptain();
    super.initState();
  }

  getCoordinatesOfCaptain() async {
    var cords =
        Provider.of<GoogleMapsProvider>(context, listen: false).coordinates;
    var data = await _store.collection("deliveryLocation").get();
    setState(() {
      destinationPosition =
          LatLng(data.docs[0].data()["lat"], data.docs[0].data()["long"]);
      initPosition = LatLng(cords.latitude, cords.longitude);
      polylines.add(
        Polyline(
            width: 5,
            color: Colors.red,
            polylineId: PolylineId(
                destinationPosition.toString()),
            points: [initPosition, destinationPosition]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GoogleMapsProvider>(
        builder: (context, provider, _) => destinationPosition == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  SafeArea(
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          polylines: Set.from(polylines),
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          mapType: MapType.hybrid,
                          initialCameraPosition:
                              CameraPosition(target: initPosition, zoom: 6),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "your order will be in:        32 mins",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(
                                            TrackCaptainScreen.nameRoute),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.grey[300]),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "  chat the captain",
                                              suffixIcon: IconButton(
                                                onPressed: () => "hee",
                                                icon: Icon(Icons.message),
                                              )),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
      ),
    );
  }
}
