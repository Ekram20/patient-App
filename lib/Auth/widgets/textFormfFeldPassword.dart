import 'package:flutter/material.dart';
class textformFieldPassword extends StatelessWidget {

  //final String? Function(String?)? validate;
  final String  hintText ;
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final Icon icon;
  final bool passToggle;
  final Widget suffix;


  const textformFieldPassword({
    super.key, required this.hintText, required this.myController,required this.icon, required this.passToggle, required this.suffix,required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: myController,
      obscureText:passToggle ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:InputDecoration(
          suffix: suffix,
          hintText: "Enter the passwoed",
          filled: true,
          fillColor:Colors.grey.shade200,
          prefixIcon: icon,
          border:OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
                color:Color.fromARGB(255, 184, 184, 184)),),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                  color:Colors.grey
              )
          )
      ) ,


     // validator: validate,
    );
  }
}
