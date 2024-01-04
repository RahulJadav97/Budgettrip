import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/user/home/model/user_inqury_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInquiryController extends GetxController{
  var isLoading = false.obs;
  var response=UserInquiryModel().obs;



  Future<void> userInquiryCont(Plan, From, To, FromDate, ToDate, Adult, Child, TransportMode, Budget, SpecialRequest)async {
    try{
      isLoading(true);
      final respo = await ApiServices().userInquiry(Plan, From, To, FromDate, ToDate, Adult, Child, TransportMode, Budget, SpecialRequest);
      if(respo.responseCode == "1"){
        response=respo.obs;

        Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Container(
                height: Get.height*0.4,
                width: Get.width*0.8,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assests/images/thank_tou_image.png"))
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              InkWell(
                onTap: (){
                  Get.to(()=>BottomNavbarScreen(newIndex: 0,));
                },
                child: Container(
                  height: Get.height*0.04,
                  width: Get.width*0.15,
                  decoration: BoxDecoration(
                    color: common_blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text("Done",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              )
            ],
          ),
        );
        print("Profile Get successfully");

      }
      else{
        response=respo.obs;
        Get.snackbar(
          "Profile Error",
          "${response.value.message}",
          icon: const Icon(Icons.cancel, color: Colors.red),
          snackPosition: SnackPosition.TOP,
        );
        print("Profile error : ${response.value.message}");
      }
    }finally{
      isLoading(false);
    }
  }
}