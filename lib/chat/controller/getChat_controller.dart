import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/getChat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetChatController extends GetxController{
  var isLoading = false.obs;
  var response=GetChatModel().obs;



  Future<void> getChatCont(SenderId)async {
    try{
      isLoading(true);
      final respo = await ApiServices().getChat(SenderId);
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Chat Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat get : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> getChatCont1(SenderId)async {
    try{

      final respo = await ApiServices().getChat(SenderId);
      if(respo.responseCode == "1"){
        response(respo);
        print("Chat Get successfully1111111111111");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat get : ${response.value.message}");
      }
    }finally{

    }
  }
}