
import 'package:ekram_project/views/users/navScreen/favorite.dart';
import 'package:ekram_project/views/users/navScreen/initialDiagnosis.dart';
import 'package:ekram_project/views/users/navScreen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'navScreen/homeScreen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0 ;

  List<Widget> _pages = [
    HomeScreen(),//0
    InitialDiagnosis(),//1
    FavoriteScreen(),//2
    ProfileScreen(),//3

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Row(
                children: [
                  Image.asset('images/logo.png',
                      width: MediaQuery.of(context).size.width/8,
                      height:MediaQuery.of(context).size.height/28
                  ),
                  Text('مرحبا بك في عيادتي'),
                ],
              ),
            Container(
              child: IconButton(
                onPressed: (){
                },
               icon:Icon(Icons.notifications),
              )
            ),
            ],
        ),
      )
      ,
      backgroundColor: Colors.grey.shade200,
       bottomNavigationBar: Container(

         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: BottomNavigationBar(

            currentIndex: _pageIndex,
            onTap: (Value){
              setState(() {
                _pageIndex = Value;
              });


            },
            selectedItemColor: Colors.grey.shade700,
            unselectedItemColor: Theme.of(context).iconTheme.color,

            items: [
              BottomNavigationBarItem
              (
                icon:SvgPicture.asset('asset/icons/home.svg',width: 26,),
                label: 'Home',
              ),
              BottomNavigationBarItem
              (
                icon:SvgPicture.asset('asset/icons/favorite.svg',width: 24,),
                label: 'Favorite',
                ),
              BottomNavigationBarItem
              (
                icon:SvgPicture.asset('asset/icons/medkit.svg',width: 30,),
                label: 'Initial Diagnosis',

                ),
              BottomNavigationBarItem
              (
                icon:SvgPicture.asset('asset/icons/profile-circle.svg',width: 28,),
                label: 'Profile',
                ),
            ]
            ),
         ),
       ),
      body:   _pages[_pageIndex],
    );
  }
}