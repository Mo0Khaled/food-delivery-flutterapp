import 'package:flutter/material.dart';


class RestaurantContainerUi extends StatelessWidget {
  final String title;
  final double rank;
  final String desiredMeals;
  final String estimatedTime;
  RestaurantContainerUi({this.rank,this.title,this.desiredMeals,this.estimatedTime});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      width: 400,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: GestureDetector(
          child: Container(child: Image.asset("assets/images/pic2.jpg",fit: BoxFit.cover,)
          )),
          footer: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(20.0)
            ),
            child: GridTileBar(
              backgroundColor: Colors.white,
              leading: Text(title,style: TextStyle(
                fontSize: 20.0
              ),),
              trailing: Container(
                width: 230,
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.star_border,color: Colors.black,size: 15,),
                      SizedBox(width: 5,),
                      Text(rank.toString(),style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(width: 10,),
                      Text("burger - drinks",style: TextStyle(
                        color: Colors.black54,
                      ),),
                      SizedBox(width: 10,),
                      Text("\$\$\$",style: TextStyle(
                        color: Colors.black54,
                      ),),
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
