
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/user/profile/edit_profile.dart';
import 'package:BudgeTrip/user/profile/model/edit_profile_model.dart';
import 'package:BudgeTrip/user/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profileGet_controller.dart';

class EditProfileController extends GetxController{
  var isLoading = false.obs;
  var response=EditProfileModel().obs;


 TextEditingController nameCTC = TextEditingController();
 TextEditingController emailCTC = TextEditingController();
 TextEditingController mobileCTC = TextEditingController();
 TextEditingController companyNameCTC = TextEditingController();
 TextEditingController companyAddressCTC = TextEditingController();

  ProfileGetController profileGetController = Get.put(ProfileGetController());

  Future<void> editProfileCont(ProfileImage)async {
    try{
      isLoading(true);
      final respo = await ApiServices().editProfile(nameCTC.text, emailCTC.text, mobileCTC.text, ProfileImage, companyNameCTC.text, companyAddressCTC.text);
      if(respo.responseCode == "1"){
        response=respo.obs;
        Get.focusScope!.unfocus();
        Get.to(()=>ProfileScreen());
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Profile edit Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Profile edit error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> editProfileCont1()async {
    try{
      isLoading(true);
      final respo = await ApiServices().editProfile1(nameCTC.text, emailCTC.text, mobileCTC.text,companyNameCTC.text, companyAddressCTC.text);
    if(respo.responseCode == "1"){
        response=respo.obs;
        Get.focusScope!.unfocus();
        Get.to(()=>ProfileScreen());
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Profile edit Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Profile edit error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}