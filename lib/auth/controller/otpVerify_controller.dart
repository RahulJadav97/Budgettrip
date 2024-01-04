import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/forgot_otp_model.dart';
import 'package:BudgeTrip/auth/model/veifyOtp_model.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:BudgeTrip/user/choose%20plan/choose_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/reset_password_screen.dart';

class OtpVerifyController extends GetxController{
  var isLoading = false.obs;
  var response=VerifyOtpModel().obs;
  var response1=ForgotOtpModel().obs;


  TextEditingController otpCTC=TextEditingController();

  Future<void> otpVerifyCont(otp)async {
    try{
      isLoading(true);
      final respo = await ApiServices().otpVerify(otp);
      if(respo.responseCode == "1"){
        response=respo.obs;
        SharedPreferences sf =await SharedPreferences.getInstance();
        sf.setString("otpStatus", response.value.user!.otpStatus.toString(),);
        SharedPreferences sf3 =await SharedPreferences.getInstance();
        sf3.setString("useridOTP", response.value.user!.id.toString(),);
        if(response.value.user!.userTypeName == "User"){
          Get.to(()=>  BottomNavbarScreen(newIndex: 0,));
        }else {
          Get.to(()=>  VenderBottomNavbarScreen(plan: "", newIndex: 0,));
        }
        // Get.to(const ChoosePlan());
        print("Otp Verify successfully");

        // Get.snackbar(
        //   "Otp has been sent to your email address",
        //   "",
        //   icon: const Icon(Icons.done_outline, color: Colors.deepOrange),
        //   snackPosition: SnackPosition.TOP,
        // );

        // Get.to(()=>otp_page(email: signupmail.text,));
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Otp verify Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Signup error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> otpVerifyCont1(otp)async {
    try{
      isLoading(true);
      final respo = await ApiServices().otpVerify(otpCTC.text);
      if(respo.responseCode == "1"){
        response=respo.obs;

        Get.to(()=> ResetPasswordScreen(userID: response.value.user!.id,));
        // if(response.value.user!.userTypeName == "User"){
        //   Get.to(()=> const ChoosePlan());
        // }else {
        //   Get.to(()=>  VenderBottomNavbarScreen(plan: "",));
        // }
        // Get.to(const ChoosePlan());
        print("Otp Verify successfully");

        // Get.snackbar(
        //   "Otp has been sent to your email address",
        //   "",
        //   icon: const Icon(Icons.done_outline, color: Colors.deepOrange),
        //   snackPosition: SnackPosition.TOP,
        // );

        // Get.to(()=>otp_page(email: signupmail.text,));
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Otp verify Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Signup error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }


  Future<void> forgotOtpCont(user_id,otp)async {
    try{
      isLoading(true);
      final respo = await ApiServices().forgotOtp(user_id,otp);
      if(respo.responseCode == "1"){
        response1=respo.obs;

        Get.to(()=> ResetPasswordScreen(userID: response.value.user!.id.toString()));
        print("Forgot otp successfully");

      }
      else{
        response1=respo.obs;
        Get.snackbar(
          "Forgot Otp Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Update notification Count Clear : ${response.value.message}");
      }
    }finally{
      isLoading(true);
    }
  }
}