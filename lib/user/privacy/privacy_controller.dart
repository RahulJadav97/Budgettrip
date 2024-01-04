
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'privacy_model.dart';

class PrivacyGetController extends GetxController{
  var isLoading = false.obs;
  var response=PrivacyModel().obs;



  Future<void> privacyGetCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().privacy();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Privacy policy Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "term and condition Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Privacy policy error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}