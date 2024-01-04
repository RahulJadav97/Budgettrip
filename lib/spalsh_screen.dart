import 'dart:async';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/screen/login_screen.dart';
import 'bottombar/vendor_bottomBar.dart';
import 'user/choose plan/choose_plan.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    userData();
    super.initState();
    Timer(const Duration(seconds: 3), () {

      if(otpStatus == "1"){
        if(userId != null && userId.toString().isNotEmpty){
          if(userType == "User"){
            Get.to(()=>  BottomNavbarScreen(newIndex: 0,));
          }else{
            Get.to(()=>  VenderBottomNavbarScreen(plan: "", newIndex: 0,));
          }
        }else{
          Get.off(const LoginScreen());
        }
      }else {
        Get.off(const LoginScreen());
      }

      print("login screen");

      // Get.off(const BottomNavbarScreen());
      // print("BottomNavbarScreen ");
    });
  }

  var userId;
  var userType;
  var otpStatus;
  var loginType;
  userData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      userId = sf.getString("userid");
      userType = sf.getString("userType");
      otpStatus = sf.getString("otpStatus");
      loginType = sf.getString("loginType");
      print("THIS IS USER ID: $userId");
      print("THIS IS USER Type: $userType");
      print("THIS IS USER otpStatus: $otpStatus");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
          image: AssetImage("assests/images/spalsh_screen_b_image.png"),
            fit: BoxFit.contain
        )
      ),
      child: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
          ),
          Positioned(
            top: Get.height*0.3,
            left: Get.width*0.170,
            child: Container(
              height: Get.height*0.3,
              width: Get.width*0.7,
              decoration: const BoxDecoration(
                  // color: Colors.blueGrey.shade100,
                  image: DecorationImage(
                      image: AssetImage("assests/images/logo.png"),
                      fit: BoxFit.cover,
                    scale: 1.0
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
