import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ekram_project/Auth/validation/emailValidation.dart';
import 'package:ekram_project/Auth/widgets/textFormfFeldPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/appColors.dart';
import '../widgets/materialButton.dart';
import '../widgets/textformField.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userName =TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController confirmpassword =TextEditingController();
  bool  passToggle = true ;
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
                    Text('SignUp',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor.shade600
                      ),
                    ),
                    Text('Signup to continue using the app',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor.shade400
                      ),
                    ),
                    SizedBox(height:35),
                    Text('User Name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor.shade500
                      ),
                    ),
                    textformField(
                     
                      validator: (username)
                        {
                          if(username!.length<1){
                            return "Enter User Name";
                          }
                          return null ;
                      
                      },
                      icon: Icon(Icons.person),
                        hintText: 'Enter the Username',
                        myController: userName),

                    SizedBox(
                      height: 20,
                    ),
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
                       validator: (value){
                      if(value == ''){
                        return 'The Email can not be empty';
                      }
                      else{
                         validateEmail(value);
                      }

                    },
                      // validate: (email) =>  validateEmail(email) ,
                        hintText: 'Enter the email Address',
                        icon: Icon(Icons.email),
                        myController: _email
                    ),
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
                     passToggle: passToggle,
                      suffix: InkWell(
                        onTap: (){
                          setState(() {
                            passToggle = !passToggle;
                              });
                          },
                        child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                      )
                                ,
                      validator: (password) =>
                                password!.length < 6
                                    ? 'The password must be at least 6 characters'
                                    : null ,

                      hintText: 'Enter the Password',
                      icon: Icon(Icons.lock),
                      myController:_password ,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Confirm Password',
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
                      passToggle: passToggle,
                     suffix: InkWell(
                                      onTap: (){
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                                    ),
                      validator:  (confirmPassword) =>
                                confirmpassword.text != _password.text
                                    ? 'Please reset your password correctly'
                                    : null ,

                      hintText: 'Enter the Confirm Password',
                      icon: Icon(Icons.lock),
                      myController:confirmpassword ,
                    ),
                    SizedBox(height: 15,),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              materialButton(text: "SignUp", onPressed :()async{
               if(_formKey.currentState!.validate()){
                 try {
                   isLoading =true;
                   setState(() {

                   });
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email.text,
                    password: _password.text,
                  );
                   isLoading =false;
                   setState(() {

                   });
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Navigator.of(context).pushReplacementNamed("login");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Weak Password',
                      desc: 'The password provided is too weak.',
                      
                      )..show();
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Email Exists',
                      desc: 'The account already exists for that email.',
                      
                      )..show();
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
               }
               
              }

              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed("login");
                },
                child: Center(
                  child: Text.rich(TextSpan(
                      children:[
                        TextSpan(text: " Have An Account ? ",),
                        TextSpan(text: "Login",
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
// import 'package:ekram_project/auth/user/userLoginScreen.dart';
// import 'package:flutter/material.dart';
// import '../../models/appColors.dart';
// import '../validation/emailValidation.dart';
// import 'authServiceUser.dart';
//
// final _formKey = GlobalKey<FormState>();
//
// class UserSignupScreen extends StatefulWidget {
//   const UserSignupScreen({super.key});
//
//
//   @override
//   State<UserSignupScreen> createState() => _UserSignupScreenState();
// }
//
// class _UserSignupScreenState extends State<UserSignupScreen> {
//
//   final _auth = AuthServiceUser();
//   TextEditingController _name = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passWordController = TextEditingController();
//   TextEditingController _confirmPasswordController =TextEditingController();
//   String groupValue ="Male";
//
//   bool  passToggle = true ;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passWordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           backgroundColor: AppColors.greyColor.shade50,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Image.asset("images/logo.png"),
//                     Text("إنشاء حساب في تطبيق عيادتي ",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           sizeBoxWidget(),
//                           Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.whiteColor,
//                                 borderRadius:  BorderRadius.circular(12),
//                               ),
//                               child: Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: TextFormField(
//                                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                                 keyboardType:TextInputType.text ,
//                                 controller: _name,
//                                 autofocus: true,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Nmae",
//                                   prefixIcon: Icon(Icons.account_circle),
//                                 ),
//                                 validator: (name)
//                                     {
//                                       if(name!.length<1){
//                                       return "الرجاء كتابة الإسم";
//                                     }
//                                       return null ;
//                               }
//                               ),
//                               ),
//                             ),
//                           ),
//                           sizeBoxWidget(),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 25),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.whiteColor,
//                                 borderRadius:  BorderRadius.circular(12),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20),
//                                 child: Column(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                       "Gender",),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Radio(
//
//                                           activeColor: AppColors.primaryColor,
//                                             value: "Male",
//                                             groupValue: groupValue,
//                                             onChanged: (value){
//                                               setState(() {
//                                                 groupValue = value! ;
//                                               });
//                                             },
//                                         ),
//                                         Text("Male"),
//                                         SizedBox(
//                                           width: 16,
//                                         ),
//                                         Radio(
//
//                                           activeColor: AppColors.primaryColor,
//                                             value: "Female",
//                                             groupValue: groupValue,
//                                             onChanged: (value){
//                                               setState(() {
//                                               groupValue = value!;
//                                               });
//                                             }
//                                         ),
//                                         Text("Female"),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           sizeBoxWidget(),
//                           emailWidget(),
//                           sizeBoxWidget(),
//                           passwordWidget(),
//                           sizeBoxWidget(),
//                           confirmPasswordWidget(),
//                           sizeBoxWidget(),
//                           signupButtonWidget(context),
//
//
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//           )
//
//     );
//
//
//   }
//
//   Padding emailWidget() {
//     return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 25),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.whiteColor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 20),
//                               child: TextFormField(
//                                controller: _emailController,
//                                 autofocus: true,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Email",
//                                   prefixIcon: Icon(Icons.email),
//                                 ),
//                                 validator:(email) => validateEmail(email) ,
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                               ),
//                             ),
//                           ),
//                         );
//   }
//
//   Padding passwordWidget() {
//     return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 25),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.whiteColor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 20),
//                               child: TextFormField(
//                                 controller: _passWordController,
//                                 obscureText: passToggle,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "PassWord",
//                                   prefixIcon: Icon(Icons.lock),
//                                   suffix: InkWell(
//                                     onTap: (){
//                                       setState(() {
//                                         passToggle = !passToggle;
//                                       });
//                                     },
//                                     child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
//                                   )
//                                 ),
//                                 validator:  (password) =>
//                                 password!.length < 6
//                                     ? 'كلمة المرور يجب ان تحتوي على 6 احرف على الاقل'
//                                     : null ,
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//
//                               ),
//                             ),
//                           ),
//                         );
//   }
//
//   SizedBox sizeBoxWidget() => SizedBox(height: 20,);
//
//   Padding confirmPasswordWidget() {
//     return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 25),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.whiteColor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 20),
//                               child: TextFormField(
//                                 controller: _confirmPasswordController,
//                                 obscureText: passToggle,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Confirm PassWord",
//                                     prefixIcon: Icon(Icons.lock_open_sharp),
//                                     suffix: InkWell(
//                                       onTap: (){
//                                         setState(() {
//                                           passToggle = !passToggle;
//                                         });
//                                       },
//                                       child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
//                                     )
//                                 ),
//                                 validator:  (password) =>
//                                 _confirmPasswordController.text != _passWordController.text
//                                     ? 'تأكد من اعادة كتابة كلمة المرور بشكل صحيح'
//                                     : null ,
//                                 autovalidateMode: AutovalidateMode.onUserInteraction,
//
//                               ),
//                             ),
//                           ),
//                         );
//   }
//
//   Padding signupButtonWidget(BuildContext context) {
//     return Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 25),
//                           child: Container(
//
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             child: Center(
//                               child:TextButton(
//                                 onPressed: (){
//                                    if(_formKey.currentState!.validate()){
//                                      _signUp();
//
//                                    }
//                                 },
//
//                                 child: Text(
//                                   "إنشاء حساب",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//   }
//
//   _signUp()async{
//
//    final user = await _auth.createUserWithEmailAndPassword(_emailController.text, _passWordController.text);
//     if(user!=null){
//       log("User created Successfully");
//       buildShowDialog(context);
//       _passWordController.clear();
//       _emailController.clear();
//       _confirmPasswordController.clear();
//     }
//
//   }
//   Future<dynamic> buildShowDialog(BuildContext context) {
//     return showDialog(
//                                     context: context,
//                                     builder:(context) => SimpleDialog(
//                                       title: Text("شروط استخدام تطبيق عيادتي",
//
//
//                                       ),
//                                       contentPadding: EdgeInsets.all(16),
//                                       children: <Widget>[
//                                         SingleChildScrollView(
//                                           child: Column(
//
//                                             children: [
//                                               Text(
//                                                 textAlign: TextAlign.left,
//                                                 "  مرحبًا بك في تطبيق عيادتي  ",
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: AppColors.blckColor,
//                                                   fontWeight: FontWeight.w700
//                                               ),
//                                               ),
//                                               Text(
//                                                 textAlign: TextAlign.end,
//                                                   "   يُقدم هذا التطبيق خدمة تشخيص طبي باستخدام تقنية الذكاء الاصطناعي وهي خدمة التشخيص المبدئي لا تعتمد اعتماد كلي على تشخيص التطبيق بل يجب عليك مراجعة طبيب مختص"),
//
//
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   " يرجى قراءة هذه الشروط بعناية قبل استخدام التطبيق .",
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600
//                                                 ),
//                                               ),
//                                               Text(
//                                                 textAlign: TextAlign.end,
//                                                 "إنشاء الحساب",
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w700
//                                                 ),
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "   لإنشاء حساب، يجب عليك تقديم معلومات دقيقة وحديثة"
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "  لإنشاء حساب، يجب عليك تقديم معلومات دقيقة وحديثة ومطلوبة أثناء عملية التسجيل "
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "  أنت مسؤول عن الحفاظ على سرية كلمة مرور حسابك والتحكم في الوصول إلى حسابك "
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "    أنت مسؤول عن جميع الأنشطة التي تحدث على حساب 1"
//                                               ),
//                                               SizedBox(height: 10,),
//                                               Text(
//                                                 textAlign: TextAlign.end,
//                                                 "استخدام الخدمة",
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w700
//                                                 ),
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "أنت توافق على استخدام الخدمة وفقًا لهذه الشروط وجميع القوانين واللوائح المعمول بها "
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   " أنت توافق على عدم استخدام الخدمة لأي غرض غير قانوني أو ضار أو مسيء "
//                                               ),
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   "  أنت توافق على عدم استخدام الخدمة بطريقة تتداخل مع أو تعطل تشغيل التطبيق أو الشبكات أو النظم المتصلة بالتطبيق "
//                                               ),
//
//                                               Text(
//                                                   textAlign: TextAlign.end,
//                                                   " "),
//
//
//                                             ],
//                                           ),
//                                         ),
//                                         Row(
//
//                                           children: [
//                                             TextButton(
//                                                 onPressed: (){
//                                                   Navigator.of(context).pop();
//                                                 }, child: Text("إغلاق")),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(16),
//                                                 color:AppColors.primaryColor,
//                                               ),
//
//                                               child: TextButton(
//
//                                                   onPressed: (){
//                                                     Navigator.pushReplacement(context,
//                                                         MaterialPageRoute<void>(
//                                                           builder: (BuildContext context) => UserLoginScreen(), ));
//                                                   }, child: Text("أوافق")),
//                                             ),
//
//                                           ],
//                                         ),
//
//                                       ],
//
//
//                                 ));
//   }
//
//
// }//end
//
