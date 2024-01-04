import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/forgot_pass_model.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassController extends GetxController{
  var isLoading = false.obs;
  var response=ForgotPassModel().obs;



  TextEditingController mobileNoCTC=TextEditingController();

  Future<void> forgotPassCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().forgot(mobileNoCTC.text);
      if(respo.responseCode == "1"){
        response=respo.obs;
        SharedPreferences sf =await SharedPreferences.getInstance();
        sf.setString("MobileNo", response.value.userData!.mobileNo.toString(),);
        // Fluttertoast.showToast(msg: "Password : ${response.value.passwordOtp.toString()}");
        Get.to(()=>OtpScreen(pageroute: '', otpRout: 'true',userID:response.value.userData!.id.toString() ,));
        // Get.to(()=> ResetPasswordScreen(userID: response.value.userData!.id.toString(),));
        print("Forgot Password successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Forgot Password Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Forgot Password error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}