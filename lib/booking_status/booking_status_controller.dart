import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/booking_status/booking_status_model.dart';
import 'package:BudgeTrip/user/inquiry_user/controller/userInquiry_get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingStatusController extends GetxController{
  var isLoading = false.obs;
  var response=BokingStatusModel().obs;

  UserInquiryGetController userInquiryGetController = Get.put(UserInquiryGetController());



  Future<void> bookingStatusCont(InquiryId)async {
    try{
      isLoading(true);
      final respo = await ApiServices().bookingStatus(InquiryId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        userInquiryGetController.userInquiryGetCont();
        print("Booking Status change successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Booking Status  Error",
          "${response.value.message}",
          icon:  Icon(Icons.cancel, color:common_blue),
          snackPosition: SnackPosition.TOP,
        );
        print("Coupon Code : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}