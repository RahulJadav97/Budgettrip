import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/update_chat_count_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateChatCountController extends GetxController{
  var isLoading = false.obs;
  var response=UpdateChatCountModel().obs;



  Future<void> updateChatCountCont(ReciverId,SenderId)async {
    try{
      final respo = await ApiServices().updateChatCount(ReciverId,SenderId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Update Chat Count Clear successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Update Chat Count Clear Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Update Chat Count Clear : ${response.value.message}");
      }
    }finally{
    }
  }
}