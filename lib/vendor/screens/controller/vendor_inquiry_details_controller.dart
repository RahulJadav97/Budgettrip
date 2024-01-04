
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/vendor/screens/model/vender_inquiry_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorInquiryDetailsController extends GetxController{
  var isLoading = false.obs;
  var response=VenderInquiryDetailsModel().obs;



  Future<void> vendorInquiryDetailsCont(InquiryId)async {
    try{
      isLoading(true);
      final respo = await ApiServices().getUserInquiryDetails(InquiryId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("User Inquiry Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "User Inquiry Details Error",
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