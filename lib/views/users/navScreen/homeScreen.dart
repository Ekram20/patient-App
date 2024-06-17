import 'package:ekram_project/models/appColors.dart';
import 'package:ekram_project/views/users/navScreen/widget/bnnerWidget.dart';
import 'package:ekram_project/views/users/navScreen/widget/searchInputWidget.dart';
import 'package:ekram_project/views/users/navScreen/widget/specialtiesWidget.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
        //  WelcomeText(),
          //SizedBox(height: 16,),
          SearchInput(),
          BannerWidget(),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(5),
            child: Text(
              'Specialties',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.greyColor.shade600
              ),
            ),
          ),
          SpecialitiesWidget(),
        ],
      ),
    );
  }
}