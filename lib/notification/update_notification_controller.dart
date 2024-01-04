
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'update_notification_model.dart';

class UpdateNotificationController extends GetxController{
  var isLoading = false.obs;
  var response=UpdateNotificationModel().obs;



  Future<void> updateNotificationCont()async {
    try{
      final respo = await ApiServices().updateNotification();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Update notification Clear successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Update notification Clear Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Update notification Count Clear : ${response.value.message}");
      }
    }finally{
    }
  }
}