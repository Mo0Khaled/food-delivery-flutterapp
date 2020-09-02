
class ImageSqlite {
  String id;
  String imageName;

  ImageSqlite({this.id, this.imageName});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"idd": id, "imageNamee": imageName};
    return map;
  }
  ImageSqlite.fromMap(Map<String, dynamic> json) {
    id = json["idd"];
    imageName = json["imageNamee"];
  }
}