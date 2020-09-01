

class ImagaSqlite{

  final String  id;
  final imageName;

  ImagaSqlite({this.id,this.imageName});


  Map<String,dynamic> toMap(){
     Map<String,dynamic> map={
      "id":id,
      "imageName":imageName
    };
  }

  factory ImagaSqlite.fromMap(Map<String, dynamic> json) => new ImagaSqlite(
    id: json["id"],
    imageName: json["imageName"],
  );


}