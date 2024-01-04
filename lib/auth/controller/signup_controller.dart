

import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/signup_model.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupController extends GetxController{
  var isLoading = false.obs;
  var response=SignupModel().obs;
  var diviceToken  = "".obs;
  String Fcmtoken  = "fcmtoken";



  TextEditingController nameCTC=TextEditingController();
  TextEditingController emailCTC=TextEditingController();
  TextEditingController mobileNoCTC=TextEditingController();
  TextEditingController passwordCTC=TextEditingController();
  TextEditingController conpasswordCTC=TextEditingController();
  TextEditingController companyNameCTC=TextEditingController();
  TextEditingController companyAddressCTC=TextEditingController();
  TextEditingController referCodeCTC=TextEditingController();


  @override
  void onInit() {
    userData();
    super.onInit();
  }

  userData() async {
    SharedPreferences sf1 = await SharedPreferences.getInstance();
    diviceToken.value = sf1.getString("DeviceToken")!;
    print("THIS IS DIVICE TOKEN1 ${diviceToken}");

  }

  Future<void> signupCont(Name, Email, MobileNo, Password, UserTypeName, CompanyName, CompanyAddress,joinreferral)async {
    try{
      isLoading(true);
      final respo = await ApiServices().signup(Name, Email, MobileNo, Password, UserTypeName, CompanyName, CompanyAddress,joinreferral,Fcmtoken.toString());
      if(respo.responseCode == "1"){
        response=respo.obs;
        print("Signup successfully");
        SharedPreferences sf =await SharedPreferences.getInstance();
        SharedPreferences sf2 =await SharedPreferences.getInstance();
        sf.setString("userid", response.value.userData!.id.toString(),);
        sf.setString("userType", response.value.userData!.userTypeName.toString(),);
        sf.setString("MobileNo", response.value.userData!.mobileNo.toString(),);
        sf2.setString("usertoken", response.value.userToken.toString(),);
        print("FCM Sig Token ${response.value.userToken.toString()}");
        if(response.value.userData!.userTypeName == "User"){
          Get.to(OtpScreen(pageroute: 'User',));
        }else {
          Get.to(OtpScreen(pageroute: 'Vendor',));
        }

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Signup Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
       print("Signup error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}