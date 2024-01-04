import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/VendorList/vendor_list_model.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/chat/model/vendor_chat_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorListController extends GetxController{
  var isLoading = false.obs;
  var response=VendorListModel().obs;

  // UserInquiryGetController userInquiryGetController = Get.put(UserInquiryGetController());



  Future<void> vendorListCont()async {
    try{
      isLoading(true);
      final respo = await ApiServices().vendorList();
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Get vendor list successfully");
      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Vendor list Error",
          "${response.value.message}",
          icon:  Icon(Icons.cancel, color:common_blue),
          snackPosition: SnackPosition.TOP,
        );
        print("get vendor list error  : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}