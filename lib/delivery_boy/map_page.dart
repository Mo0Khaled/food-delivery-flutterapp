import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// some constant
//TODO:move the from here later!!!
const double CAMERA_ZOOM = 17;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng DELIVERY_BOY_LOCATION = LatLng(30.132678, 31.284063);
const LatLng CUSTOMER_LOCATION = LatLng(30.133534, 31.278650);

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // controller for the first run for the map
  Completer<GoogleMapController> _controller = Completer();

  // the points in the map
  Set<Marker> _markers = Set<Marker>();

  // draw a polyLine for the distance between two points(markers)
  Set<Polyline> _polyLines = Set<Polyline>();

  // list of lat and long two draw the line
  List<LatLng> polylineCoordinates = [];

  // to get the object that get dist between two point
  PolylinePoints polylinePoints;

  // google api id
  String googleApiKey = 'AIzaSyDVXmPaoj7dr49OnZDAYsocACc0lGg9Aw4';

  // markers
  BitmapDescriptor deliveryBoyIcon;
  BitmapDescriptor customerIcon;

  //  to get the current location for the delivery boy
  LocationData deliveryBoyCurrentLocation;

  // the customer location
  LocationData customerDestinationLocation;

  // to listen for the delivery boy locations updates
  Location location;

  @override
  void initState() {
    super.initState();
    location = Location();
    polylinePoints = PolylinePoints();
    location.onLocationChanged.listen((LocationData cLoc) {
      deliveryBoyCurrentLocation = cLoc;
      updatePinOnMap();
    });
    showPinOnMap();
    setDeliveryBoyAndCustomerIcons();
    setInitialLocation();
  }

  void setDeliveryBoyAndCustomerIcons() {
    deliveryBoyIcon = BitmapDescriptor.defaultMarkerWithHue(152);
    customerIcon = BitmapDescriptor.defaultMarker;
  }

  setInitialLocation() async {
    deliveryBoyCurrentLocation = await location.getLocation();
    customerDestinationLocation = LocationData.fromMap({
      "latitude": CUSTOMER_LOCATION.latitude,
      "longitude": CUSTOMER_LOCATION.longitude
    });
  }

  void showPinOnMap() {
    var deliveryBoyPosition = LatLng(
      deliveryBoyCurrentLocation.latitude,
      deliveryBoyCurrentLocation.longitude,
    );
    var customerPosition = LatLng(
      customerDestinationLocation.latitude,
      customerDestinationLocation.longitude,
    );
    _markers.add(
      Marker(
        markerId: MarkerId("delivery"),
        icon: deliveryBoyIcon,
        position: deliveryBoyPosition,
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId("user"),
        icon: customerIcon,
        position: customerPosition,
      ),
    );

    setPolyLines();
  }

  setPolyLines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
        deliveryBoyCurrentLocation.latitude,
        deliveryBoyCurrentLocation.longitude,
      ),
      PointLatLng(
        customerDestinationLocation.latitude,
        customerDestinationLocation.longitude,
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    setState(
      () {
        Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates,
        );
        _polyLines.add(polyline);
      },
    );
  }

  updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(
        deliveryBoyCurrentLocation.latitude,
        deliveryBoyCurrentLocation.longitude,
      ),
    );
    final GoogleMapController controller =await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      var pinPosition =
      LatLng(deliveryBoyCurrentLocation.latitude, deliveryBoyCurrentLocation.longitude);
      _markers.removeWhere((m) => m.markerId.value == "soursePin");
      _markers.add(
        Marker(
          markerId: MarkerId("soursePin"),
          position: pinPosition, // updated position
          icon: deliveryBoyIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: DELIVERY_BOY_LOCATION,
    );
    if (deliveryBoyCurrentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(deliveryBoyCurrentLocation.latitude,
            deliveryBoyCurrentLocation.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polyLines,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
               showPinOnMap();
            },
          ),
        ],
      ),
    );
  }
}
