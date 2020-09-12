import 'package:delivery_food/providers/google_maps_provider.dart';
import 'package:delivery_food/screens/tracking_captain_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapsScreen extends StatefulWidget {
  static const String nameRoute = "/google-maps";
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
//  LatLng _initialPosition = LatLng(30.033333, 31.233334);

  @override
  void initState() {
    triggerFunctions();
    super.initState();
  }

  triggerFunctions() async {
    await Provider.of<GoogleMapsProvider>(context, listen: false)
        .getCurrentLocation();
    await Provider.of<GoogleMapsProvider>(context, listen: false).updateOrderItem();
    await Provider.of<GoogleMapsProvider>(context, listen: false).getPlaceName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GoogleMapsProvider>(
        builder: (context, provider, _) => provider.coordinates == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(provider.coordinates.latitude,
                              provider.coordinates.longitude),
                          zoom: 10),
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
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Choose shipping address",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: provider.streetName,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        provider.getCurrentLocation();
                                      },
                                      icon: Icon(Icons.border_color),
                                      color: Color(0xFFffb218),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(TrackCaptainScreen.nameRoute),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xFFffb218),
                                  ),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: 50,
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
