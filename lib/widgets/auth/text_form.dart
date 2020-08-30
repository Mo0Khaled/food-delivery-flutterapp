import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/authinticate_provider.dart';

class CustomizedTextFormField extends StatelessWidget {
  final String title;
  final Function onSaved;
  final bool neednumbersKeyboard;
  final bool isObsecure;
  final TextEditingController controller;

  CustomizedTextFormField({this.title, this.onSaved,this.neednumbersKeyboard,this.isObsecure,this.controller});
  String validate(value){
    String error;
    if(value.isEmpty){
      switch(title){
        case "User Name":
          error="title is not good";
          break;
        case "email":
          error="email";
          break;
        case "password":
          error="password";
          break;
        case "phone Number":
          error="phone";
          break;
      }
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Autheticate>(
      builder: (context,auth,_) =>
       Card(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: controller,
            obscureText:isObsecure ? auth.isObsecure: false,
            validator: validate,
            onSaved: onSaved,
            cursorColor: Colors.black,
            keyboardType:neednumbersKeyboard?TextInputType.number:null,
            decoration: InputDecoration(
              suffixIcon:IconButton(
                icon:isObsecure?
                auth.isObsecure? Icon(Icons.visibility_off):Icon(Icons.visibility):Icon(Icons.email,color: Colors.white,),
                onPressed: ()=> auth.handleObsecure(),
              ),
              border: InputBorder.none,
              labelText: title,
              labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
          ),
          ),
        ),
    );
  }
}
