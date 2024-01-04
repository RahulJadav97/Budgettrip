import 'package:BudgeTrip/Common/common_baseurl.dart';
import 'package:BudgeTrip/api_services/api_services.dart';
import 'package:BudgeTrip/auth/model/social_register_model.dart';
import 'package:BudgeTrip/auth/screen/otp_screen.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:BudgeTrip/user/home/screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class SocialRegisterController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var loading1 = false.obs;
  var loading = false.obs;
  var appleloading = false.obs;
  var appleloading1 = false.obs;
  var diviceToken  = "".obs;

  var response = SocialRegisterModel().obs;
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


  Future<void> socialRegister(UserTypeName) async {
    try {
      if(UserTypeName == "User"){
        loading1(true);
      }else{
        loading(true);
      }



      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        logger.i(value.user!.displayName.toString());
        logger.i(value.user!.email.toString());
        logger.i(value.user!.photoURL.toString());

        var res = await ApiServices().socialRegister(value.user!.displayName.toString(), value.user!.email.toString(), UserTypeName,diviceToken.toString());
        logger.i(res.status);
        if (res.responseCode == '1') {

          response = res.obs;
          SharedPreferences sf =await SharedPreferences.getInstance();
          SharedPreferences sf2 =await SharedPreferences.getInstance();
          sf.setString("userid", response.value.userData!.id.toString(),);
          sf.setString("otpStatus", response.value.userData!.otpStatus.toString(),);
          sf.setString("userType", response.value.userData!.userTypeName.toString(),);
          sf.setString("MobileNo", response.value.userData!.mobileNo.toString(),);
          sf2.setString("usertoken", response.value.userToken.toString(),);
          if(response.value.userData!.userTypeName.toString() == "User"){
            Get.offAll(()=>BottomNavbarScreen(newIndex: 0,));
          }else{
            Get.offAll(()=>VenderBottomNavbarScreen(plan: "", newIndex:0,));
          }


          // if(response.value.userData!.signinType == "Mobile"){
          //   if(response.value.userData!.userTypeName == "User"){
          //     Get.to(OtpScreen(pageroute: 'User',));
          //   }else {
          //     Get.to(OtpScreen(pageroute: 'Vendor',));
          //   }
          // }else{
          //   if(response.value.userData!.userTypeName == "User"){
          //     Get.offAll(()=>BottomNavbarScreen(newIndex: 0,));
          //     // Get.to(OtpScreen(pageroute: 'User',));
          //   }else {
          //     Get.offAll(()=>VenderBottomNavbarScreen(plan: "", newIndex:0,));
          //     // Get.to(OtpScreen(pageroute: 'Vendor',));
          //   }
          // }


        } else {
          Get.snackbar(
            "Google Login Error",
            "${res.message}",
            // backgroundColor: Colors.black,
            icon: const Icon(Icons.error, color: Colors.deepOrange),
            snackPosition: SnackPosition.TOP,
          );
        }
      });
    } finally {
      loading1(false);
      loading(false);
    }
  }

  void appleSign(UserTypeName) async {
    AuthorizationResult authorizationResult =
    await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (authorizationResult.status) {
      case AuthorizationStatus.authorized:
        print("authorized");
        try {
          AppleIdCredential? appleCredentials = authorizationResult.credential;
          OAuthProvider oAuthProvider = OAuthProvider("apple.com");
          OAuthCredential oAuthCredential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleCredentials!.identityToken!),
              accessToken:
              String.fromCharCodes(appleCredentials.authorizationCode!));
          print(appleCredentials.email);
          print(appleCredentials.fullName);
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
          if (userCredential.user != null) {
            var res = await ApiServices().socialRegister(userCredential.user!.displayName.toString(), userCredential.user!.email.toString(), UserTypeName,diviceToken.toString());
            logger.i(res.status);
            if (res.responseCode == '1') {
              response = res.obs;
              SharedPreferences sf =await SharedPreferences.getInstance();
              SharedPreferences sf2 =await SharedPreferences.getInstance();
              sf.setString("userid", response.value.userData!.id.toString(),);
              sf.setString("otpStatus", response.value.userData!.otpStatus.toString(),);
              sf.setString("userType", response.value.userData!.userTypeName.toString(),);
              sf.setString("MobileNo", response.value.userData!.mobileNo.toString(),);
              sf2.setString("usertoken", response.value.userToken.toString(),);
              if(response.value.userData!.userTypeName.toString() == "User"){
                Get.offAll(()=>BottomNavbarScreen(newIndex: 0,));
              }else{
                Get.offAll(()=>VenderBottomNavbarScreen(plan: "", newIndex:0,));
              }

            } else {
              Get.snackbar(
                "Apple Login Error",
                "${res.message}",
                // backgroundColor: Colors.black,
                icon: const Icon(Icons.error, color: Colors.deepOrange),
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        } catch (e) {
          appleloading(false);
          print("apple auth failed $e");
        }

        break;
      case AuthorizationStatus.error:
        print("error" + authorizationResult.error.toString());
        break;
      case AuthorizationStatus.cancelled:
        print("cancelled");
        break;
      default:
        print("none of the above: default");
        break;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    print("firebase logout");
  }

}