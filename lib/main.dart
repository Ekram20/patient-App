
import 'package:ekram_project/firebase_options.dart';
import 'package:ekram_project/views/users/onBoardingView.dart';
import 'package:ekram_project/models/appColors.dart';
import 'package:ekram_project/views/users/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/view/userLoginScreen.dart';
import 'Auth/view/userSigupScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.remove();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
  );
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding")??false;
  runApp( MyApp(onboarding: onboarding,));
}

class MyApp extends StatefulWidget {
  final bool onboarding ;
  const MyApp({super.key,  this.onboarding = false});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('%%%%%%%%%%%%%%%%%%%%%%User is currently signed out!');
      } else {
        print('%%%%%%%%%%%%%%%%%%%%%%%User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //fullness screen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:AppColors.primaryColor,
        fontFamily: 'ElMessiri',
        focusColor: AppColors.greyColor.shade600,


        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor.shade100,
        ),
        iconTheme: IconThemeData(
          color: AppColors.greyColor.shade700,
          size: 24,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          titleTextStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 17,
            fontFamily:'ElMessiri'
          ),
          iconTheme: IconThemeData(
            color: AppColors.whiteColor,
            size: 24,
          )
        )



      ),
      initialRoute: '/',
      routes: {
        //'/': (context) => const SplashScreen(),

        '/OnBoarding': (context) => const OnBoardingView(),
        '/main' :(context) => const MainScreen(),
        'signUp':(context) => const SignUpScreen(),
        'login':(context) => const UserLoginScreen(),
        'MainScreen':(context) => const MainScreen(),

      },

    home:(
      FirebaseAuth.instance.currentUser != null
       &&
      FirebaseAuth.instance.currentUser!.emailVerified
         ) ? MainScreen() : OnBoardingView()
        //OnBoardingView()
    //  UserLoginScreen()
    // //onboarding? MainScreen() : const OnBoardingView(),
    //   MainScreen()
    );
  }
}