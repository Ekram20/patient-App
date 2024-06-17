import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ekram_project/Auth/validation/emailValidation.dart';
import 'package:ekram_project/Auth/widgets/textFormfFeldPassword.dart';
import 'package:ekram_project/models/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/materialButton.dart';
import '../widgets/textformField.dart';
class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool passToggle=true;
    bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png',
            width: 50,
              height: 50
            ),
            Text("عيادتي",
              style: TextStyle(
                  color: AppColors.whiteColor
              ),

            ),
          ],
        ),
        backgroundColor: AppColors.primaryColor,
      ) ,
      body:isLoading ? Center(child: CircularProgressIndicator(),): Container(
        color: AppColors.whiteColor,
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal:20),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Text('Login',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor.shade600,
                      ),
                    ),
                    Text('Login to continue using the app',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor.shade400,
                      ),
                    ),
                    SizedBox(height:35),
                    Text('Email',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor.shade500
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  textformField(
                    validator: (value) {
                      if(value == ''){
                        return 'The Email can not be empty';
                      }
                      else{
                         validateEmail(value);
                         return null;
                      }

                    },
                    icon:Icon( Icons.email),
                      // validate: (email) =>  validateEmail(email) ,
                      hintText: 'Enter the email Address',
                      myController: email),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyColor.shade500
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textformFieldPassword(
                      suffix: InkWell(
                        onTap: (){
                          setState(() {
                          passToggle = !passToggle;
                          });
                          },
                            child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                          ),
                      passToggle:passToggle ,
                      validator: (password) =>
                        password!.length < 6
                        ? 'The password must be at least 6 characters'
                        : null ,
                      icon:Icon( Icons.lock),
                      //message: "Enter your password correctly",
                      hintText: 'Enter the Password',
                      myController:password ,

                    ),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: ()async{
                        if(email.text == ""){
                        AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'fill email field',
                        desc: 'please fill email field .',
                        // btnCancelOnPress: () {},
                        // btnOkOnPress: () {},
                        )..show();
                        return ;
                        }

                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail
                          (email: email.text.trim());
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'open Gmail',
                          desc: 'please reset your password .',
                          // btnCancelOnPress: () {},
                          // btnOkOnPress: () {},
                        )..show();
                      }catch(e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'error in email',
                          desc: 'please enter correct email .',
                          // btnCancelOnPress: () {},
                          // btnOkOnPress: () {},
                        )..show();
                      }


                        },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                            'Forgot Password ?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              materialButton(text: "Login", onPressed :()async{
                if(_formKey.currentState!.validate()){
                  try {
                    isLoading =true;
                    setState(() {

                    });
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text
                    );
                    isLoading =false;
                    setState(() {

                    });
                    if(credential.user!.emailVerified){
                       Navigator.of(context).pushReplacementNamed("MainScreen");
                    }
                    else{
                       AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Verified Email',
                      desc: 'please Verified your email .',
                      // btnCancelOnPress: () {},
                      // btnOkOnPress: () {},
                      )..show();
                    }
                   
                  } on FirebaseAuthException catch (e) {
                    isLoading =false;
                    setState(() {

                    });
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Wrong Email',
                      desc: 'No user found for that email.',
                      // btnCancelOnPress: () {},
                      // btnOkOnPress: () {},
                      )..show();
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Wrong password',
                      desc: 'Wrong password provided for that user.',
                      // btnCancelOnPress: () {},
                      // btnOkOnPress: () {},
                      )..show();
                    }
                  }
                }
                

              }),
              SizedBox(height: 25,),

              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed("signUp");
                },
                child: Center(
                  child: Text.rich(TextSpan(
                    children:[
                      TextSpan(text: "Don`t Have An Account ? ",),
                      TextSpan(text: "Register",
                      style: TextStyle(color: AppColors.primaryColor,
                      fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                      )
                    ]


                  )),
                ),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}






//
// import 'dart:developer';
//
// import 'package:ekram_project/login/user/authServiceUser.dart';
// import 'package:ekram_project/login/user/userSigupScreen.dart';
// import 'package:ekram_project/login/validation/emailValidation.dart';
// import 'package:ekram_project/models/appColors.dart';
// import 'package:ekram_project/views/users/main_screen.dart';
// import 'package:flutter/material.dart';
//
// final _formKey = GlobalKey<FormState>();
//
// class UserLoginScreen extends StatefulWidget {
//   const UserLoginScreen({super.key});
//
//   @override
//   State<UserLoginScreen> createState() => _UserLoginScreenState();
// }
//
// class _UserLoginScreenState extends State<UserLoginScreen> {
//   final _emailController = TextEditingController();
//   final _passWordController = TextEditingController();
//   final _auth = AuthServiceUser();
//
//   bool passToggle = true;
//
//
//
// @override
//   void dispose() {
//   _emailController.dispose();
//   _passWordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyColor.shade50,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text("تسجيل الدخول كمستخدم ",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//               Form(
//                 key:_formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     sizedBoxWidget(),
//                     emailWidget(),
//                     sizedBoxWidget(),
//                     passwordWidget(),
//                     sizedBoxWidget(),
//                     loginButtonWidget(context),
//
//
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: (){
//
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserSignupScreen()));
//
//                      // PushReplacement(MaterialPageRoute(builder: (context) => UserSignupScreen()));
//                     },
//                     child: Text("أنشئ حساب ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: AppColors.primaryColor,
//
//                       ),),
//                   ),
//                   Text("ليس لدي حساب ؟",
//                  ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
//
//   SizedBox sizedBoxWidget() => SizedBox(height: 20,);
//
//   Padding loginButtonWidget(BuildContext context) {
//     return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 25),
//                     child: Container(
//
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       child: Center(
//                         child:TextButton(
//                           onPressed: (){
//                             if(_formKey.currentState!.validate()){
//                               _login();
//                             }
//                           },
//
//                           child: Text(
//                             "تسجيل الدخول",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//   }
//
//   Padding passwordWidget() {
//     return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.whiteColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: TextFormField(
//                           controller: _passWordController,
//                           obscureText: passToggle,
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "PassWord",
//                               prefixIcon: Icon(Icons.lock),
//
//                               suffixIcon: InkWell(
//                                 onTap: (){
//                                   setState(()
//                                   {
//                                     passToggle = !passToggle;
//                                   }
//                                   );
//                                 },
//                                 child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
//                               ),
//                           ),
//
//                           validator:  (password) =>
//                               password!.length < 6
//                             ? 'كلمة المرور يجب ان تحتوي على 6 احرف على الاقل'
//                                   : null ,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                         ),
//
//                       ),
//                     ),
//                   );
//   }
//   Padding emailWidget() {
//     return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.whiteColor,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: TextFormField(
//                           controller: _emailController,
//                           autofocus: true,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Email",
//                             prefixIcon: Icon(Icons.email)
//
//                           ),
//
//                           validator:(email) => validateEmail(email) ,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                         ),
//                       ),
//                     ),
//                   );
//   }
//   _login()async{
//     final user =await _auth.loginUserWithEmailAndPassword(_emailController.text, _passWordController.text);
//     if(user != null){
//       log("User Logged In");
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
//     }
//   }
// }
