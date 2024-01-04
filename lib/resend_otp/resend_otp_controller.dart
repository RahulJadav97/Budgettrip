
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:BudgeTrip/resend_otp/resend_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResendOtpController extends GetxController{
  var isLoading = false.obs;
  var response=ResendOtpModel().obs;



  Future<void> resendOtpCont(MobileNo)async {
    try{
      isLoading(true);
      final respo = await ApiServices().resendOtp(MobileNo);
      if(respo.responseCode == "1"){
        response=respo.obs;
        if(response.value.userData!.userTypeName == "User"){
          Get.to(OtpScreen(pageroute: 'User',));
        }else {
          Get.to(OtpScreen(pageroute: 'Vendor',));
        }
        print("Resend Otp successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Resend Opt Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Resend Otp Code : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> resendOtpCont1(MobileNo)async {
    try{
      isLoading(true);
      final respo = await ApiServices().resendOtp(MobileNo);
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Resend Otp successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Resend Opt Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Resend Otp Code : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}