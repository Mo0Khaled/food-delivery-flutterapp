import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_svg/flutter_svg.dart';



Widget singlePage(String title,String imgName,String description,BuildContext ctx){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(imgName,width:MediaQuery.of(ctx).size.width*0.7,height:MediaQuery.of(ctx).size.height*0.299 ,),
      SizedBox(height: 30.0,),
      Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 35.0,
          fontFamily: "HindSiliguri"),),
      SizedBox(height: MediaQuery.of(ctx).size.height *0.022,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(description,textAlign: TextAlign.center,style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 17.0
        ),),
      ),
    ],
  );
}



Widget button(BuildContext ctx,Color color,String title,Function fun,bool isBlack){
  return GestureDetector(
    onTap: fun,
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(ctx).size.height *0.07,
      width:MediaQuery.of(ctx).size.width *0.87 ,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 0.2),
          color: color,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Text(title,style: TextStyle(color: isBlack? Colors.white:Colors.black,fontSize: 15,
          fontWeight: isBlack? null:FontWeight.w600),
      ),
    ),
  );
}
