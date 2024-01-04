import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'getAll_notification_model.dart';

class GetAllNotificationController extends GetxController{
  var isLoading = false.obs;
  var response=GetAllNotificationModel().obs;



  Future<void> getAllNotificationCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().notificationList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Notification list Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Notification list : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}