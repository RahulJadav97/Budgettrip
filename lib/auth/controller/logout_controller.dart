import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/forgot_pass_model.dart';
import 'package:BudgeTrip/auth/model/logout_model.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController{
  var isLoading = false.obs;
  var response=LogoutModel().obs;

  Future<void> logoutcont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().logout();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("LOGOUT SUCCESS!!!!!!!!!!!!!!!!");
        Get.to(()=> LoginScreen());
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Error Occurred!!",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("LOGOUT error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}