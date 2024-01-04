import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/user/inquiry_user/controller/userInquiry_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cancel_status_model.dart';

class CancelStatusController extends GetxController{
  var isLoading = false.obs;
  var response=CancelStatusModel().obs;

  UserInquiryGetController userInquiryGetController = Get.put(UserInquiryGetController());



  Future<void> cancelStatusCont(InquiryId)async {
    try{
      isLoading(true);
      final respo = await ApiServices().cancelStatus(InquiryId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        Get.back();
        userInquiryGetController.userInquiryGetCont();
        print("Booking Status change successfully");
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Cancel Status  Error",
          "${response.value.message}",
          icon:  Icon(Icons.cancel, color:common_blue),
          snackPosition: SnackPosition.TOP,
        );
        print("Cancel Status : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}