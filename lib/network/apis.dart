import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  // create a new instance of fireStore
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // passing the path of the collection
  final String path;
  // instance of collection to do all the settings
  CollectionReference ref;
  // get the path
  Api(this.path){
    ref = _db.collection(path);
  }
  // get the data via future now streams
  Future<QuerySnapshot> getDataCollection(){
    return ref.get();
  }
  // get the data via streamBuilder
  Stream<QuerySnapshot> streamDataCollection(){
    return ref.snapshots();
  }
  // to get the id of the data
  Future<DocumentSnapshot> getDocById(String id){
    return ref.doc(id).get();
  }
  // delete one item
  Future<void> removeDoc(String id){
    return ref.doc(id).delete();
  }
  // to add new data on fire store
  Future<DocumentReference> addDoc(Map data){
    return ref.add(data);
  }
  //update item
  Future<void> updateDoc(Map data,String id){
    return ref.doc(id).update(data);
  }

}
