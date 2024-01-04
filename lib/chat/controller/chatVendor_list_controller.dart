import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/vendor_chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatVendorListController extends GetxController{
  var isLoading = false.obs;
  var response=VendorChatListModel().obs;



  Future<void> chatVendorListCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().chatVendorList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Profile Get successfully");
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat vendor list Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat vender list : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> chatVendorListCont1()async {
    try{
      final respo = await ApiServices().chatVendorList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("user list successfully");
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat vendor list Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat vender list : ${response.value.message}");
      }
    }finally{
    }
  }
}