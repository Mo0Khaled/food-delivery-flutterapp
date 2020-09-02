import 'dart:io';

class ImagaSqlite {
  String id;
  String imageName;

  ImagaSqlite({this.id, this.imageName});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"idd": id, "imageNamee": imageName};
    return map;
  }

  ImagaSqlite.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    imageName = json["imageName"];
  }
}
