import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/user/inquiry_user/model/userInquiry_get_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInquiryGetController extends GetxController{
  var isLoading = false.obs;
  var response=UserInquiryGetModel().obs;



  Future<void> userInquiryGetCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().getUserInquiry();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("User Inquiry Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "User Inquiry Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("User Inquiry get : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}