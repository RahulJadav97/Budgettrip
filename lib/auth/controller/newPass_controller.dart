import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/newPass_model.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassController extends GetxController{
  var isLoading = false.obs;
  var response=NewPasswordModel().obs;



  TextEditingController newPasswordCTC=TextEditingController();
  TextEditingController conPasswordCTC=TextEditingController();

  Future<void> newPassCont(user_id)async {
    try{
      isLoading(true);
      final respo = await ApiServices().newPassword(user_id, newPasswordCTC.text, conPasswordCTC.text);
      if(respo.responseCode == "1"){
        response=respo.obs;
        Get.to(()=>const LoginScreen());
        print("New Password set successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "New Password Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("New Password error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}