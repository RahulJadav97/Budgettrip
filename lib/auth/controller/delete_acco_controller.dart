import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/delete_acc_model.dart';
import 'package:BudgeTrip/auth/model/forgot_pass_model.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'social_register_controller.dart';

class DeleteAccountController extends GetxController{
  var isLoading = false.obs;
  var response=DeleteAccountModel().obs;

  SocialRegisterController socialRegisterController = Get.put(SocialRegisterController());



  Future<void> deleteAccountCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().delete_account();
      if(respo.responseCode == "1"){
        response=respo.obs;
        socialRegisterController.signOut();
        SharedPreferences sf = await SharedPreferences.getInstance();
        sf.clear();
        Get.to(()=> LoginScreen());
        print("Account Deleted successfully");
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Account Deletion Error!!",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Account Delete error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}