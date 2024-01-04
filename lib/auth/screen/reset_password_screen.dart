import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/controller/newPass_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  var userID ;
   ResetPasswordScreen({Key? key,required this.userID}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  NewPassController newPassController = Get.put(NewPassController());




  bool obscureText=true;
  bool obscureText1=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.050,),
                // image contanier
                Container(
                  // padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  height: Get.height*0.350,
                  // color: Colors.orange,
                  child: const Image(image: AssetImage("assests/images/Reset password-amico 1.png"),),
                ),
                SizedBox(height: Get.height*0.030,),

                Text("Reset Password", style: FontStyles.black_35_w700),
                SizedBox(height: Get.height*0.020,),
                Text("Please Enter Your New Password ", style: FontStyles.grey_15_w400,),
                SizedBox(height: Get.height*0.040,),

                Text("New Password",style: FontStyles.black_18_w500),
                SizedBox(height: Get.height*0.020,),
                //new password:
                CommonTextFormField(
                  maxLines: 1,
                  controller: newPassController.newPasswordCTC,
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
                      child: Icon(obscureText==true?Icons.remove_red_eye:Icons.remove_red_eye_outlined, color: common_blue,)), autofocus: false, readOnly: false,
                ),
                SizedBox(height: Get.height*0.020,),


                Text("Confirm New Password",style: FontStyles.black_18_w500,),
                SizedBox(height: Get.height*0.020,),
                //confirm password


                CommonTextFormField(
                  maxLines: 1,
                  controller: newPassController.conPasswordCTC,
                  hintText: "Password",
                  textInputFormatter: [],
                  obscureText: obscureText1,
                  prefixIcon: Icon(Icons.lock_outline, color: common_blue,),
                  suffixIcon: InkWell(
                      onTap: (){
                        setState(() {
                          obscureText1 = !obscureText1;
                          print("obscureText1 :$obscureText1");
                        });
                      },
                      child: Icon(obscureText1==true?Icons.remove_red_eye:Icons.remove_red_eye_outlined, color: common_blue,)), autofocus: false, readOnly: false,
                ),
                SizedBox(height: Get.height*0.060,),






                // continue container:

                Obx(() => newPassController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if(newPassController.newPasswordCTC.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter New Password");
                    }else if(newPassController.conPasswordCTC.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter Confirm Password");
                    }else
                    if(newPassController.newPasswordCTC.text != newPassController.conPasswordCTC.text){
                      Fluttertoast.showToast(msg: "New Password & Confirm Password Is Not Match ");
                    }else
                    {
                      newPassController.newPassCont(widget.userID.toString());
                    }

                  },
                  child: CommonBlueButton(txt: 'Continue',),
                ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
