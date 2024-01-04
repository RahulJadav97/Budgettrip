import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/controller/login_controller.dart';
import 'package:BudgeTrip/auth/controller/social_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Signup_screen.dart';
import 'forgot_password.dart';
import 'dart:io';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.put(LoginController());
  SocialRegisterController socialRegisterController = Get.put(SocialRegisterController());

  TextEditingController _MobileController = TextEditingController();
  // String fire_key = "";

  bool obscureText = true;
  // userData() async {
  //   print("jjjjbj");
  //   SharedPreferences sf1 = await SharedPreferences.getInstance();
  //   setState(() {
  //
  //   fire_key = sf1.getString("DeviceToken").toString();
  //   });
  //   print("THIS IS DIVICE TOKEN2 ${fire_key}");
  // }

  @override
  void initState() {
    _checkDevice();
    // loginController.mobileNoCTC.clear();
    // loginController.passwordCTC.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: Get.height*0.3,
                  width: Get.width*0.4,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assests/images/signup_top_leftconner_image.png"),
                          fit: BoxFit.cover
                      )
                  ),

                ),
                Positioned(
                  bottom: -55,
                  right: Get.width*0.0,
                  child: Container(
                    height: Get.height*0.30,
                    width: Get.width*0.35,
                    decoration:  const BoxDecoration(
                      // color: Colors.blueGrey.shade100,
                        image: DecorationImage(
                            image: AssetImage("assests/images/signup_bottom_right_conner_image.png"),
                            fit: BoxFit.contain
                          // scale: 1.5
                        )
                    ),

                  ),
                ),

                // login full container:
                Center(
                  child: Container(
                    height: Get.height,
                    width: Get.width*0.9,
                    // color: Colors.lightBlueAccent.withOpacity(0.4),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*0.24,),

                          Center(child: Text("Login", style: FontStyles.black_35_w700)),
                          SizedBox(height: Get.height*0.030,),

                          Text("Mobile Number", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),

                          // login textform field
                          CommonTextFormField(
                            keyboardType:TextInputType.phone,
                            hintText: "Mobile No",
                            controller: loginController.mobileNoCTC,
                            // textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                            obscureText: false,
                            prefixIcon: Icon(Icons.call_outlined, color: common_blue,), autofocus: false, textInputFormatter: [], readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.010,),
                          Text("Password", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),

                          // login textform field
                          CommonTextFormField(
                            hintText: "Password",
                            controller: loginController.passwordCTC,
                            maxLines: 1,
                            // textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                            obscureText: obscureText,
                            prefixIcon: Icon(Icons.lock, color: common_blue,), autofocus: false, textInputFormatter: [],
                            suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    obscureText = !obscureText;
                                    print("obscureText :$obscureText");
                                  });
                                },
                                child: Icon(obscureText==true?Icons.remove_red_eye:Icons.remove_red_eye_outlined, color: common_blue,)), readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.050,),

                          Center(child: GestureDetector(
                              onTap: (){
                                Get.to(const ForgotPasswordScreen());
                              },
                              child: Text("Forgot Password?", style: FontStyles.blue_20_w400,))),
                          SizedBox(height: Get.height*0.040,),

                          //Login button
                          Obx(() => loginController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                          InkWell(
                              onTap: (){
                                if (loginController.mobileNoCTC.text.length != 10){
                                  Fluttertoast.showToast(msg: "Please Enter 10 Digit Mobile No.");
                                }else
                                if (loginController.mobileNoCTC.text.isEmpty){
                                  Fluttertoast.showToast(msg: "Please Enter Mobile No.");
                                }else
                                if (loginController.passwordCTC.text.isEmpty){
                                  Fluttertoast.showToast(msg: "Please Enter Password");
                                }else{
                                  loginController.loginCont();
                                }


                              },
                              child: CommonBlueButton(txt: "Login")),
                          ),

                          SizedBox(height: Get.height*0.030,),

                          Container(
                            width: Get.width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: Get.height*0.001,
                                  width: Get.width*0.250,
                                  color: Colors.grey,
                                ),
                                Text("or continue with", style: FontStyles.grey_15_w400,),

                                Container(
                                  height: Get.height*0.001,
                                  width: Get.width*0.250,
                                  color: Colors.grey,
                                )

                              ],
                            ),
                          ),

                          SizedBox(height: Get.height*0.030,),

                          // google & facebook& apple:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.defaultDialog(
                                      title: "Please Select Your Type",
                                      content: Center(
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                                          children: [
                                            /// --------- user ----- ////
                                            Obx(() => socialRegisterController.loading1.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                                            InkWell(
                                              onTap: (){
                                                socialRegisterController.socialRegister("User");
                                                // socialRegisterController.socialRegister1("Vendor");
                                              },
                                              child: Container(
                                                height: Get.height*0.04,
                                                width: Get.width*0.3,
                                                decoration: BoxDecoration(
                                                    color: common_blue,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: Center(
                                                  child: Text("User",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            )),
                                            /// ------ vendor ----- /////
                                            Obx(() => socialRegisterController.loading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                                            InkWell(
                                              onTap: (){
                                                socialRegisterController.socialRegister("Vendor");
                                                // socialRegisterController.socialRegister1("Vendor");
                                              },
                                              child: Container(
                                                height: Get.height*0.04,
                                                width: Get.width*0.3,
                                                decoration: BoxDecoration(
                                                    color: common_blue,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: Center(
                                                  child: Text("Vendor",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            )),

                                          ],
                                        ),
                                      )
                                  );
                                  // Get.to();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: Get.height*0.070,
                                  width: Get.width*0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child:  Image.asset("assests/images/google_logo.webp"),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: (){
                              //     // Get.to();
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.all(10.0),
                              //     height: Get.height*0.070,
                              //     width: Get.width*0.2,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       shape: BoxShape.circle,
                              //       // borderRadius: BorderRadius.all(Radius.circular(10)),
                              //       border: Border.all(color: Colors.black.withOpacity(0.05)),
                              //
                              //     ),
                              //     child:  Image.asset("assests/images/FaceBook_logo.webp"),
                              //   ),
                              // ),
                              checkAndroid != true?
                              GestureDetector(
                                onTap: (){
                                  Get.defaultDialog(
                                      title: "Please Select Your Type",
                                      content: Center(
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                                          children: [
                                            /// --------- user ----- ////
                                            Obx(() => socialRegisterController.appleloading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                                            InkWell(
                                              onTap: (){
                                                socialRegisterController.appleSign("User");
                                                // socialRegisterController.socialRegister1("Vendor");
                                              },
                                              child: Container(
                                                height: Get.height*0.04,
                                                width: Get.width*0.3,
                                                decoration: BoxDecoration(
                                                    color: common_blue,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: Center(
                                                  child: Text("User",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            )),
                                            /// ------ vendor ----- /////
                                            Obx(() => socialRegisterController.appleloading1.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                                            InkWell(
                                              onTap: (){
                                                socialRegisterController.appleSign("Vendor");
                                                // socialRegisterController.socialRegister1("Vendor");
                                              },
                                              child: Container(
                                                height: Get.height*0.04,
                                                width: Get.width*0.3,
                                                decoration: BoxDecoration(
                                                    color: common_blue,
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                child: Center(
                                                  child: Text("Vendor",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            )),

                                          ],
                                        ),
                                      )
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,

                                  height: Get.height*0.070,
                                  width: Get.width*0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child:  Icon(Icons.apple, color: Color(0xff3F3E3E).withOpacity(0.9),size: 35,),
                                ),
                              ):SizedBox(),
                            ],
                          ),
                          SizedBox(height: Get.height*0.020,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don’t Have An Account?", style: FontStyles.grey_15_w400,),
                              InkWell(
                                  onTap: (){
                                    Get.to(const SignupScreen());
                                  },
                                  child: Text(" Sign Up", style: FontStyles.blue_15_w600,)),
                            ],
                          )






                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  var checkAndroid = false;
  void _checkDevice() {
    if (Platform.isAndroid) {
      setState(() {
        checkAndroid = true;
      });
    } else if (Platform.isIOS) {
      print('Running on iOS!');
    } else {
      print('Running on neither Android nor iOS!');
    }
  }

}
