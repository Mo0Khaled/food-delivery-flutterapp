
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleMapsProvider with ChangeNotifier {
  LocationData coordinates;
  var streetName;
  FirebaseFirestore _store=FirebaseFirestore.instance;




  Future<void> getCurrentLocation() async {
    Location location = Location();
    coordinates = await location.getLocation();
    notifyListeners();
  }


  void updateOrderItem()async{
    String id=FirebaseAuth.instance.currentUser.uid;
    var documents=await _store.collection("orders").where("id",isEqualTo:id).get();
    for(var document in documents.docs){
       var documentId=document.id;
      _store.collection("orders").doc(documentId).update({
        "lat":coordinates.latitude,
        "long":coordinates.longitude
      });
      notifyListeners();
    }
  }


  Future<void> getPlaceName() async {
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude,
        localeIdentifier: "en_US");
    streetName = placemarks[0].street;
  }
}
