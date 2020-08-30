import 'package:flutter/material.dart';

class RestaurantContainerUi extends StatelessWidget {
  final String title;
  final double rank;
  final String desiredMeals;
  final String estimatedTime;

  RestaurantContainerUi(
      {this.rank, this.title, this.desiredMeals, this.estimatedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: GestureDetector(
              child: Container(
                  child: Image.asset(
            "assets/images/pic2.jpg",
            fit: BoxFit.cover,
          ))),
          footer: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GridTileBar(
              backgroundColor: Colors.white,
              leading: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              trailing: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "burger - drinks",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\$\$\$",
                      overflow: TextOverflow.ellipsis,
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
    );
  }
}
