import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/controller/signup_controller.dart';
import 'package:BudgeTrip/auth/model/login_model.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:BudgeTrip/resend_otp/resend_otp_controller.dart';
import 'package:BudgeTrip/user/choose%20plan/choose_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  var isLoading = false.obs;
  var response=LoginModel().obs;
  String diviceToken = "";


  ResendOtpController resendOtpController = Get.put(ResendOtpController());
  SignupController signupcont = Get.put(SignupController());

  TextEditingController mobileNoCTC=TextEditingController();
  TextEditingController passwordCTC=TextEditingController();

  @override
  void onInit() {
    // userData();
    super.onInit();
  }

  // userData() async {
  //   print("jjjjbj");
  //   SharedPreferences sf1 = await SharedPreferences.getInstance();
  //   diviceToken = sf1.getString("DeviceToken").toString();
  //   print("THIS IS DIVICE TOKEN2 ${diviceToken}");
  // }

  Future<void> loginCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().login(mobileNoCTC.text, passwordCTC.text,signupcont.Fcmtoken.toString());
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Login successfully");
        print("FMC tockennnnnnnnnnn ${response.value.userData!.fireKey}");
        print("User id : ${response.value.userData!.id}");
        SharedPreferences sf =await SharedPreferences.getInstance();
        SharedPreferences sf2 =await SharedPreferences.getInstance();
        sf.setString("userid", response.value.userData!.id.toString(),);
        sf.setString("userType", response.value.userData!.userTypeName.toString(),);
        sf.setString("otpStatus", response.value.userData!.otpStatus.toString(),);
        sf.setString("MobileNo", response.value.userData!.mobileNo.toString(),);
        print("user Token ${response.value.userToken.toString()}");
        sf2.setString("usertoken", response.value.userToken.toString(),);
        print("FCM Token ${response.value.userToken.toString()}");
        if(response.value.userData!.otpStatus == "0"){
          resendOtpController.resendOtpCont(response.value.userData!.mobileNo.toString());
        }else
        if(response.value.userData!.userTypeName == "User"){
          Get.to(()=>BottomNavbarScreen(newIndex: 0,));
        }else {
          Get.to(()=>  VenderBottomNavbarScreen(plan: "", newIndex: 0,));
        }

      }
      else{
        response=respo.obs;
        if(response.value.message == "Please Verify Otp."){
          Get.to(OtpScreen(pageroute: 'done',mobile:response.value.userData!.mobileNo.toString(),));

        }
        // Get.defaultDialog(
        //   title: "Are you sure verify otp",
        //   titleStyle: TextStyle(color: common_blue),
        //   content: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       InkWell(
        //         onTap: (){
        //           Get.back();
        //         },
        //         child: Container(
        //           height: Get.height*0.04,
        //           width: Get.width*0.3,
        //           decoration: BoxDecoration(
        //               color: common_blue,
        //               borderRadius: BorderRadius.circular(100)
        //           ),
        //           child: Center(
        //             child: Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        //           ),
        //         ),
        //       ),
        //       InkWell(
        //        onTap:  (){
        //          if(response.value.message == "Please Verify Otp."){
        //            Get.to(OtpScreen(pageroute: ''))?.then((value) =>  resendOtpController.resendOtpCont(response.value.userData!.mobileNo.toString()));
        //
        //          }
        //         },
        //         child: Container(
        //           height: Get.height*0.04,
        //           width: Get.width*0.3,
        //           decoration: BoxDecoration(
        //               color: common_blue,
        //               borderRadius: BorderRadius.circular(100)
        //           ),
        //           child: Center(
        //             child: Text("Verify",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        //           ),
        //         ),
        //       )
        //     ],
        //   )
        // );
        Get.snackbar(
          "Login Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Login error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}