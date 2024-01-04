import 'dart:io';

import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/addChat_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddChatController extends GetxController{
  var isLoading = false.obs;
  var response=AddChatModel().obs;

  TextEditingController msgCTC = TextEditingController();
  ScrollController scrollController = ScrollController();
  scrollToLastMessage() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> addChatCont(ReciverId,Message)async {
    try{
      isLoading(true);
      final respo = await ApiServices().addChat(ReciverId, Message);
      if(respo.responseCode == "1"){
        response=respo.obs;
        scrollToLastMessage();
        msgCTC.clear();
        print("Add Chat successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Add Chat Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Add Chat : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> addChatCont1(ReciverId,Document)async {
    try{
      isLoading(true);
      final respo = await ApiServices().addChat1(ReciverId,"", Document);
      if(respo.responseCode == "1"){
        response=respo.obs;
        scrollToLastMessage();
        msgCTC.clear();

        print("Add Chat successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Add Chat Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Add Chat : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
  var isImage = false.obs;





}