
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'term_model.dart';

class TermGetController extends GetxController{
  var isLoading = false.obs;
  var response=TermModel().obs;



  Future<void> termGetCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().term();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("term Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "term and condition Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("term and condition error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}