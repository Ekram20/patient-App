import 'package:ekram_project/onBarding/onBoardingItems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Auth/view/userLoginScreen.dart';





class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final controller =OnBoardingItems();
  final pageController = PageController();

  bool isLastPage =false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () =>pageController.jumpToPage(controller.items.length-1),
             child: Text("Skip",
                textAlign: TextAlign.center,
                style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,

          ),
                )),
               
        SmoothPageIndicator(
          controller: pageController,
          count: controller.items.length,
          onDotClicked: (index) => pageController.animateToPage(index,
           duration: Duration(microseconds: 600), curve: Curves.easeIn),
          effect:  WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor:Theme.of(context).primaryColor

          ),
           ),
        
               TextButton(onPressed: ()=> pageController.nextPage(duration: const Duration(microseconds: 600), curve: Curves.easeIn),
             child:  Text("Next",
                textAlign: TextAlign.center,
                style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor

          ),
             
              ))
          ],
        ),
      ),
      body:Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(()=>
            isLastPage =controller.items.length-1 ==index
          ),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index){
             return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 16,),
                Text
                (
                 controller.items[index].title,
                 textAlign: TextAlign.center,
                 style:TextStyle(
                 fontWeight: FontWeight.w900
                  ),
                ),
                const SizedBox(height: 16,),
                Text
                (
                  controller.items[index].description,
                  textAlign: TextAlign.center,
                  style:TextStyle(
                  fontSize: 18
                   ),
                )
                
           
              ],
             );
          }
          ),
      ) ,
    );
  }
  //Get Started button
    Widget getStarted(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)
        
          ),
          
          width: MediaQuery.of(context).size.width * .9,
          height: 55,
          child: TextButton(onPressed:()async{
            final pres = await SharedPreferences.getInstance();

            if(!mounted)return;
            pres.setBool("onboarding", true);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => UserLoginScreen()) );
          } ,
          child:  Text("Get Started",
             textAlign: TextAlign.center,
              style:Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 18,
              color: Colors.white
            ),
        
          )),
        ),
      );
    }
}


