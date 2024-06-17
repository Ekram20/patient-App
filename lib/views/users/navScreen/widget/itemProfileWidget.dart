import 'package:ekram_project/models/appColors.dart';
import 'package:flutter/material.dart';

class ItemProfile extends StatelessWidget {
  const ItemProfile({super.key, this.onPressed, required this.title, required this.icon});
 final void Function()? onPressed;
 final String title;
 final Icon icon;
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.whiteColor,
        boxShadow:
        [
          BoxShadow(
            color: AppColors.greyColor.shade50,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: icon,
        title: Text(title),
        onTap: () {
        },
        trailing: Icon(Icons.arrow_forward_ios,size: 18,),
    
      ),
    ),
  );
  }
}