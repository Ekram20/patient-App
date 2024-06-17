import 'package:flutter/material.dart';

import '../../models/appColors.dart';
class materialButton extends StatelessWidget {
  final String text ;
  final void Function()? onPressed;
  const materialButton({
    super.key, required this.text, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
      )
      ,
      color: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      onPressed: onPressed,
      child: Text(text,
        style: TextStyle(
            fontSize: 20
        ),),
    );
  }
}