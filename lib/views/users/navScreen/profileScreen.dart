import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekram_project/models/appColors.dart';
import 'package:ekram_project/views/users/navScreen/widget/itemProfileWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
final FirebaseAuth _auth =FirebaseAuth.instance;
String? email = FirebaseAuth.instance.currentUser!.email;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage:CachedNetworkImageProvider('https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg'),
              ),
              SizedBox(height: 20),
              Text("Ekram Alordawi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )
              ),
              SizedBox(height:10),
              Text(email!,
          
              style: TextStyle(
                fontSize: 16,
              )),
              SizedBox(height: 50),
              ItemProfile(title: "about", icon: Icon(Icons.info_outline_rounded),
              onPressed: (){
                
              },
              ),
              SizedBox(height: 24),
              ItemProfile(title: "Connect Us", icon: Icon(Icons.phone),
              onPressed: (){

              },
              ),
              SizedBox(height: 24),

              Container(
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
                  leading:  Icon(Icons.login_outlined),
                  title: Text('LogOut'),
                  onTap: ()async {
                 
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Sign Out',
                      desc: 'Are you sure to log out?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                         _auth.signOut();
                           Navigator.pushNamedAndRemoveUntil(context, '/OnBoarding', ModalRoute.withName('/'));
                      },
                      )..show();
                
                 // Navigator.pushNamedAndRemoveUntil(context, 'OnBoarding', (route)=> false);
                    // Navigator.of(context).pushNamedAndRemoveUntil('OnBoarding', (route)=> false);
                  },
                  trailing: Icon(Icons.arrow_forward_ios,size: 18,),
                ),
              ),

             
              SizedBox(height: 28),
              ElevatedButton(
                style: ButtonStyle(
                  padding:WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 100,vertical: 10)),
                  elevation: WidgetStateProperty.all(8),
                  backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                ),
                  onPressed: (){
                  },
                child: Text("Edit Profile",
          
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))
              ,)
          
            ],
          ),
        ),
      ),
    );



  }
}
