import 'package:flutter/material.dart';
class textformField extends StatelessWidget {

  //final String? Function(String?)? validate;
  final String  hintText ;
  final TextEditingController myController;
  final Icon icon;
  final String? Function(String?)? validator;

  const textformField({
    super.key, required this.hintText, required this.myController,required this.icon,required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: myController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:InputDecoration(
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
              ),
          ),
      ),
        // validator: validate,
    );
  }
}
