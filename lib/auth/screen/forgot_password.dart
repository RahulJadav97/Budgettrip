import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/controller/forgotPassword_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ForgotPassController forgotPassController = Get.put(ForgotPassController());

  TextEditingController _MobileController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height*0.080),
        child: Container(
          decoration: BoxDecoration(
            color: common_blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          ),
          child: AppBar(
            elevation: 0,
            leading: Icon(Icons.arrow_back, color: Colors.white,),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width:Get.width*0.9,
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
                  child: Image(image: AssetImage("assests/images/Forgot password-amico 1.png"),),
                ),
                SizedBox(height: Get.height*0.030,),

                Text("Forgot Password", style: FontStyles.black_24_w600),
                SizedBox(height: Get.height*0.020,),
                Text("Don’t Worry it happens, please enter the Mobile No. associated with your account.", style: FontStyles.grey_15_w400,),
                SizedBox(height: Get.height*0.060,),

                Text("Mobile Number",style: FontStyles.black_18_w500,),
                SizedBox(height: Get.height*0.020,),
                // mobile textformfield container:
                CommonTextFormField(
                  keyboardType:TextInputType.phone,
                  hintText: "Mobile No",
                  controller: forgotPassController.mobileNoCTC,
                  obscureText: false,
                  prefixIcon: Icon(Icons.call_outlined, color: common_blue,), autofocus: false,
                  textInputFormatter: [], readOnly: false,
                ),

                SizedBox(height: Get.height*0.050,),

                Obx(() => forgotPassController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                InkWell(
                  onTap: (){
                    if (forgotPassController.mobileNoCTC.text.length != 10){
                      Fluttertoast.showToast(msg: "Please Enter 10 Digit Mobile No.");
                    }else
                    if(forgotPassController.mobileNoCTC.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter Mobile no.");
                    }else{
                      forgotPassController.forgotPassCont();
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
