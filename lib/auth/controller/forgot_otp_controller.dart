import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/forgot_otp_model.dart';
import 'package:BudgeTrip/auth/screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotOtpController extends GetxController{
  var isLoading = false.obs;
  var response=ForgotOtpModel().obs;



  Future<void> forgotOtpCont(user_id,otp)async {
    try{
      final respo = await ApiServices().forgotOtp(user_id,otp);
      if(respo.responseCode == "1"){
        response=respo.obs;

        Get.to(()=> ResetPasswordScreen(userID: response.value.userDetails!.id.toString()));
        print("Forgot otp successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Forgot Otp Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Update notification Count Clear : ${response.value.message}");
      }
    }finally{
    }
  }
}