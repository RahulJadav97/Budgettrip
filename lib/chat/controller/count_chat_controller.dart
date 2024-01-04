import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/count_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountChatController extends GetxController{
  var isLoading = false.obs;
  var response=CountChatModel().obs;



  Future<void> countChatCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().countChat();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Count chat successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Count Chat Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Count Chat Error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}