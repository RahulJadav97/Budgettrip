
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/controller/login_controller.dart';
import 'package:BudgeTrip/user/profile/model/profileGet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileGetController extends GetxController{
  var isLoading = false.obs;
  var response=GetProfileModel().obs;
  LoginController loginController = Get.put(LoginController());

  

  Future<void> profileGetCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().profileGet();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Profile Get successfully ");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Profile Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Profile error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
  Future<void> profileGetCont1()async {
    try{
      loginController.mobileNoCTC.clear();
      loginController.passwordCTC.clear();
      final respo = await ApiServices().profileGet();
      if(respo.responseCode == "0"){
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.clear();
        response=respo.obs;
        print("");

      }
      else{
        response=respo.obs;
        print("Profile error : ${response.value.message}");
      }
    }finally{
    }
  }
}