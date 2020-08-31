import 'package:flutter/material.dart';

class RestaurantContainerUi extends StatelessWidget {
  final String title;
  final double rank;
  final String desiredMeals;
  final String estimatedTime;
  final String imgUrl;
  RestaurantContainerUi(
      {this.rank,
      this.title,
      this.desiredMeals,
      this.estimatedTime,
      this.imgUrl});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      width: mediaQuery.width * 0.7,
      height: mediaQuery.height * 0.26,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: GestureDetector(
            child: Stack(children: <Widget>[
              Container(
                  width: double.infinity,
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                left: mediaQuery.width * 0.65,
                top: mediaQuery.height * 0.173,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 18,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        estimatedTime,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
              )
            ]),
          ),
          footer: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(20.0)),
            child: GridTileBar(
              backgroundColor: Colors.white,
              leading: Container(
                width: mediaQuery.width * 0.2,
                child: Text(
                  title.length > 10 ? "${title.substring(0, 8)}..." : title,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              trailing: Container(
                width: mediaQuery.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.star_border,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        rank.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        desiredMeals,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "\$\$\$",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
