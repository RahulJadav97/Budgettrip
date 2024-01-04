import 'dart:io';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/controller/signup_controller.dart';
import 'package:BudgeTrip/auth/controller/social_register_controller.dart';
import 'package:BudgeTrip/user/term%20and%20condition/term_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'login_screen.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  SignupController signupController = Get.put(SignupController());



  TermGetController termGetController = Get.put(TermGetController());
  SocialRegisterController socialRegisterController = Get.put(SocialRegisterController());

  bool ischeck = false;
  bool obscureText = true;
  String? selectedChoice='User';

  @override
  void initState() {
    _checkDevice();
    termGetController.termGetCont();
    super.initState();
    selectedChoice='User';
    print('selectedChoice :$selectedChoice');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: Get.height*0.28,
              width: Get.width*0.34,
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
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*0.23,),

                          Center(child: Text("Sign UP", style: FontStyles.black_35_w700)),
                          SizedBox(height: Get.height*0.01,),

                          Text("Choose", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          /// user dropdown
                          Container(
                            height: Get.height*0.080,
                            child: DropdownButtonFormField(
                              decoration:  InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: const Color(0xffF2F2F2) ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color:const Color(0xffF2F2F2) ),
                                ),
                                filled: true,
                                fillColor:Colors.transparent,
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: Get.width*0.080),
                                child: const Text("Choose", ),
                              ) ,
                              dropdownColor: Colors.white,
                              value: selectedChoice,
                                items: <String>['User', 'Vendor'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                      child: Text("$value")
                                  );
                                }).toList(),
                                onChanged: (value) {
                                 setState(() {
                                   selectedChoice = value.toString();
                                   print('selectedChoice one :$selectedChoice');
                                 });
                                },
                            ),
                          ),


                          SizedBox(height: Get.height*0.02,),


                          Text("Name", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          CommonTextFormField(
                            autofocus: false,
                            controller: signupController.nameCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Your Name";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Name",
                            textInputFormatter: [],
                            obscureText: false,
                            prefixIcon: Icon(Icons.person_outline, color: common_blue,), readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.02,),


                          Text("Email", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          CommonTextFormField(
                            autofocus: false,
                            controller: signupController.emailCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Email";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Email",
                            textInputFormatter: [],
                            obscureText: false,
                            prefixIcon: Icon(Icons.email_outlined, color: common_blue,), readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.02,),

                          selectedChoice !='User'?Container():Text("Refer Code", style: FontStyles.black_18_w500),
                          selectedChoice !='User'?Container():SizedBox(height: Get.height*0.010,),
                          selectedChoice !='User'?Container():CommonTextFormField(
                            autofocus: false,
                            controller: signupController.referCodeCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Email";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Refer Code",
                            textInputFormatter: [],
                            obscureText: false,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Image.asset("assests/images/rupee_icon.png",color: common_blue,height: Get.height*0.01,width: Get.width*0.01,),
                            ), readOnly: false,
                          ),
                          selectedChoice !='User'?SizedBox():SizedBox(height: Get.height*0.02,),


                          Text("Mobile Number", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          CommonTextFormField(
                            autofocus: false,
                            controller: signupController.mobileNoCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Mobile Number";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Mobile Number",
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            prefixIcon: Icon(Icons.call_outlined, color: common_blue,), textInputFormatter: [], readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.02,),

                          Text("Password", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          CommonTextFormField(
                            maxLines: 1,
                            autofocus: false,
                            controller: signupController.passwordCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Password";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Password",
                            textInputFormatter: [],
                            obscureText: obscureText,
                            prefixIcon: Icon(Icons.lock_outline, color: common_blue,),
                            suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    obscureText = !obscureText;
                                    print("obscureText :$obscureText");
                                  });
                                },
                                child: Icon(obscureText==true?Icons.remove_red_eye:Icons.remove_red_eye_outlined, color: common_blue,)), readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.02,),
                          Text("Confirm Password", style: FontStyles.black_18_w500),
                          SizedBox(height: Get.height*0.010,),
                          CommonTextFormField(
                            maxLines: 1,
                            autofocus: false,
                            controller: signupController.conpasswordCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Enter Password";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Confirm Password",
                            textInputFormatter: [],
                            obscureText: obscureText,
                            prefixIcon: Icon(Icons.lock_outline, color: common_blue,),
                            suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    obscureText = !obscureText;
                                    print("obscureText :$obscureText");
                                  });
                                },
                                child: Icon(obscureText==true?Icons.remove_red_eye:Icons.remove_red_eye_outlined, color: common_blue,)), readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.02,),

                          selectedChoice =='User'?Container():Text("Company Name ", style: FontStyles.black_18_w500),
                          selectedChoice =='User'?Container():SizedBox(height: Get.height*0.010,),
                          selectedChoice =='User'?Container():CommonTextFormField(
                            autofocus: false,
                            controller: signupController.companyNameCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Company Name ";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Company Name",
                            textInputFormatter: [],
                            obscureText: false, readOnly: false,
                          ),
                          selectedChoice =='User'?Container():SizedBox(height: Get.height*0.020,),

                          selectedChoice =='User'?Container():Text("Company Address ", style: FontStyles.black_18_w500),
                          selectedChoice =='User'?Container():SizedBox(height: Get.height*0.010,),
                          selectedChoice =='User'?Container():CommonTextFormField(
                            autofocus: false,
                            controller: signupController.companyAddressCTC,
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Company Address";
                              }else{
                                return null;
                              }
                            },
                            hintText: "Company Address(Optional)",
                            textInputFormatter: [],
                            obscureText: false, readOnly: false,
                          ),
                          SizedBox(height: Get.height*0.010,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    ischeck = !ischeck;
                                    ischeck == true?Get.defaultDialog(

                                        title: "Terms and Conditions",
                                        titleStyle: TextStyle(color: common_blue),
                                        content:Scrollbar(
                                          // thumbVisibility:true,
                                          child: Container(
                                              height: Get.height*0.5,
                                              child: SingleChildScrollView(child:
                                              Html(
                                                data: termGetController.response.value.termsConditions!.text.toString(),
                                              )
                                                // Text("${termController.response.value.data!.description}",)
                                              )),
                                        )
                                    ):"";
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color:
                                    ischeck == true ? common_blue : Colors.transparent,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: Get.width*0.75,
                                  child: Text("I Accept All Terms & Conditions and Privacy Policy", style: FontStyles.black_15_w400,)),
                            ],
                          ),
                          SizedBox(height: Get.height*0.040,),

                          //Signup button
                          Obx(() => signupController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                          GestureDetector(
                              onTap: (){
                                if(ischeck == true){

                                  if(selectedChoice == 'User'){
                                    if (signupController.mobileNoCTC.text.length != 10){
                                      Fluttertoast.showToast(msg: "Please Enter 10 Digit Mobile No.");
                                    }else
                                    if(signupController.nameCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Name");
                                    }else
                                    if(signupController.emailCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Email");
                                    }else
                                    if(signupController.mobileNoCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Mobile No.");
                                    }else
                                    if(signupController.passwordCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Password");
                                    }
                                    if (signupController.passwordCTC.text != signupController.conpasswordCTC.text){
                                      Fluttertoast.showToast(msg: "Password And Confirm Password Not Match");
                                    }else
                                      signupController.signupCont(
                                          signupController.nameCTC.text,
                                          signupController.emailCTC.text,
                                          signupController.mobileNoCTC.text,
                                          signupController.passwordCTC.text,
                                          selectedChoice.toString(),/// selected user or vendor
                                          selectedChoice =='User'?"": signupController.companyNameCTC.text,
                                          selectedChoice =='User'?"" :signupController.companyAddressCTC.text,
                                        signupController.referCodeCTC.text
                                      );
                                    // Get.to(OtpScreen(pageroute: 'User',));
                                  }else{
                                    if (signupController.mobileNoCTC.text.length != 10){
                                      Fluttertoast.showToast(msg: "Please Enter 10 digit Mobile No.");
                                    }else
                                    if(signupController.nameCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Name");
                                    }else
                                    if(signupController.emailCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Email");
                                    }else
                                    if(signupController.mobileNoCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Mobile No.");
                                    }else
                                    if(signupController.passwordCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Password");
                                    }else
                                    if(signupController.companyNameCTC.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Please Enter Company Name");
                                    }else {
                                      signupController.signupCont(
                                          signupController.nameCTC.text,
                                          signupController.emailCTC.text,
                                          signupController.mobileNoCTC.text,
                                          signupController.passwordCTC.text,
                                          selectedChoice.toString(),/// selected user or vendor
                                          selectedChoice =='User'?"": signupController.companyNameCTC.text,
                                          selectedChoice =='User'?"" :signupController.companyAddressCTC.text,
                                          signupController.referCodeCTC.text
                                      );
                                    }
                                    // Get.to(OtpScreen(pageroute: 'Vendor',));
                                  }

                                }else{
                                  Fluttertoast.showToast(msg: "Please Accept Privacy Policy..");
                                }
                              },
                              child: CommonBlueButton(txt: "Sign Up")),
                          ),

                          SizedBox(height: Get.height*0.030,),

                          Row(
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

                          SizedBox(height: Get.height*0.020,),

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
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                              Text("Already Have An Account? ", style: FontStyles.grey_15_w400,),
                              GestureDetector(
                                  onTap: (){
                                    Get.to(const LoginScreen());
                                  },
                                  child: Text("Login", style: FontStyles.blue_15_w600,)),
                            ],
                          ),
                          SizedBox(height: Get.height*0.030,),
                        ],
                      ),
                    ),
                  ),
                )
            )
          ],
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
