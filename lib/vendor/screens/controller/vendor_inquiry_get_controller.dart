
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/vendor/screens/model/vender_inquiryGet-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorInquiryGetController extends GetxController{
  var isLoading = false.obs;
  var response=VenderInquiryGetModel().obs;



  Future<void> vendorInquiryGetCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().getVenderInquiry();
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