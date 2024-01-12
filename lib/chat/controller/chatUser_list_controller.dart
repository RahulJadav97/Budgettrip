
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_services/api_services.dart';
import '../model/chatUser_list_model.dart';

class ChatUserListController extends GetxController{
  var isLoading = false.obs;
  var response=ChatUserListModel().obs;



  Future<void> chatUserListCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().chatUserList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat user list Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat user list : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> chatUserListCont1()async {
    try{

      final respo = await ApiServices().chatUserList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Chat user list Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Chat user list : ${response.value.message}");
      }
    }finally{
    }
  }
}