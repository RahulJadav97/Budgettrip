import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/user/inquiry_user/controller/userInquiry_get_controller.dart';
import 'package:BudgeTrip/user_inquiry_list/user_inquiry_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'confirm_booking_model.dart';

class ConfirmBookingStatusController extends GetxController{
  var isLoading = false.obs;
  var response=ConfirmBookingModel().obs;

  UserInquiryGetController userInquiryGetController = Get.put(UserInquiryGetController());



  Future<void> ConfirmBookingStatusCont(InquiryId,VendorId)async {
    try{
      isLoading(true);
      final respo = await ApiServices().ConfirmBookingStatus(InquiryId, VendorId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        userInquiryGetController.userInquiryGetCont();
        Get.to(()=>UserInquiryListScreen());
        print("Booking Status change successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Confirm Booking Status  Error",
          "${response.value.message}",
          icon:  Icon(Icons.cancel, color:common_blue),
          snackPosition: SnackPosition.TOP,
        );
        print("Confirm Booking Status Code : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}