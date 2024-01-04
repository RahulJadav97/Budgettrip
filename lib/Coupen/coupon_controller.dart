
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coupon_model.dart';

class CouponController extends GetxController{
  var isLoading = false.obs;
  var response=CouponModel().obs;



  Future<void> couponCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().couponCode();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Coupon Code successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Coupon code Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Coupon Code : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}