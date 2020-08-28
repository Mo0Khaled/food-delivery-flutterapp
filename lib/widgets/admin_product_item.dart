import 'package:delivery_food/providers/product_provider.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String img;

  AdminProductItem({this.id, this.title, this.img});

  @override
  Widget build(BuildContext context) {
    final ourProduct = Provider.of<ProductProvider>(context,listen: false);
    final scaffold = Scaffold.of(context);
    return Container(
      color: Color(0xFFF4F4F4),
      child: ListTile(
        title: Text(title),
        leading: Image.network(img,width: 50,height: 50,),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              IconButton(icon: Icon(Icons.edit), onPressed: () {
                Navigator.of(context).pushNamed(MangeProductsScreen.routeId,arguments: id);           }
              ),
              IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: ()async {
                try{
                  await ourProduct.deleteProduct(id);
                }catch(error){
                  scaffold.showSnackBar(SnackBar(content: Text("Delete Failed")));
                }
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
