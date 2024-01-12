
import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Coupen/coupen_screen.dart';
import 'package:BudgeTrip/auth/controller/delete_acco_controller.dart';
import 'package:BudgeTrip/auth/controller/logout_controller.dart';
import 'package:BudgeTrip/auth/controller/social_register_controller.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:BudgeTrip/chat/screen/user_list.dart';
import 'package:BudgeTrip/chat/screen/vender_list.dart';
import 'package:BudgeTrip/user/choose%20plan/choose_plan.dart';
import 'package:BudgeTrip/user/home/screen/search_screen.dart';
import 'package:BudgeTrip/user/privacy/privacy_screen.dart';
import 'package:BudgeTrip/user/profile/save_profile.dart';
import 'package:BudgeTrip/user/term%20and%20condition/term_screen.dart';
import 'package:BudgeTrip/user_inquiry_list/user_inquiry_list_screen.dart';
import 'package:BudgeTrip/vendor/screens/my_inquiry_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/profileGet_controller.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileGetController profileGetController = Get.put(ProfileGetController());
  SocialRegisterController socialRegisterController = Get.put(SocialRegisterController());
  DeleteAccountController deleteAccountController = Get.put(DeleteAccountController());
  LogoutController logoutController = Get.put(LogoutController());


  FocusNode focusNode = FocusNode();
var referCode ;
  Timer? _timer;
  @override
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      print("object2");
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.offAll(LoginScreen());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userData();
      profileGetController.profileGetCont().then((value) =>  setState(() {

        referCode = profileGetController.response.value.userData!.myreferral.toString();
        print("referCode ${referCode}");
      }));
    });

  
    super.initState();
  }

  var userType;
  userData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      userType = sf.getString("userType");
      print("THIS IS USER Type $userType");
    });
  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(() => profileGetController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height*0.230,
              width: Get.width,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                 color: common_blue
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profileGetController.response.value.userData!.profileImage!.isEmpty?
                  Container(
                    height: Get.height*0.1,
                    width: Get.width*0.3,
                    decoration:  const BoxDecoration(
                      // color: Colors.blueGrey,
                        image: DecorationImage(image: AssetImage('assests/images/persion_blue_img.png')),
                        shape: BoxShape.circle
                    ),
                  ):
                  Container(
                    height: Get.height*0.1,
                    width: Get.width*0.3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 2),
                        // color: Colors.blueGrey,
                        image: DecorationImage(image: NetworkImage(profileGetController.response.value.userData!.profileImage.toString()),fit: BoxFit.fill),
                        shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(height: Get.height*0.015,),
                  Text("${profileGetController.response.value.userData!.name}", style: FontStyles.white_15_w500,),
                ],
              ),
            ),
            Container(
              // height: Get.height*0.8,
              // width: Get.width,
              child: Padding(
                padding:  EdgeInsets.all(Get.width*0.02),
                child: Column(
                  children: [
                    SizedBox(height: Get.height*0.02,),
                    /// ------- Home -------///
                    // userType == "User"?
                    // InkWell(
                    //   onTap: (){
                    //     if(userType == "User"){
                    //       Get.to(()=> BottomNavbarScreen(newIndex: 2,));
                    //     }else{
                    //       Get.to(()=>  VenderBottomNavbarScreen(plan: "", newIndex: 0,));
                    //     }
                    //
                    //   },
                    //   child: Container(
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Icon(Icons.home_outlined,color: common_blue,size: Get.height*0.04,),
                    //             SizedBox(width: Get.width*0.05,),
                    //             Text("Home",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    //             Spacer(),
                    //             Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                    //           ],
                    //         ),
                    //         SizedBox(height: Get.height*0.008,),
                    //         Divider()],
                    //     ),
                    //   ),
                    // ):Container(),
                    /// ------- Inquiry List -------///
                    userType == "User"?
                    InkWell(
                      onTap: (){
                        Get.to(()=>  UserInquiryListScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.ac_unit,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("My Inquiry",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ):Container(),
                    /// ------- Edite profile -------///
                    SizedBox(height: Get.height*0.01,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>SaveProfileScreen());
                        Get.focusScope!.unfocus();
                        focusNode.unfocus();
                        // Get.to(()=>EditProfileScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Edit Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    /// ------- Add Inquiry -------///
                   userType == "User"?SizedBox(height: Get.height*0.01,):SizedBox(),
                    userType == "User"?
                    InkWell(
                      onTap: (){
                        Get.to(()=> SearchScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.add_circle_outline_sharp,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Add Inquiry",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ):Container(),
                    /// ------- Chat -------///
                    SizedBox(height: Get.height*0.01,),
                    InkWell(
                      onTap: (){
                        print("$userType");
                        userType == "User"?
                        Get.to(()=>UserListScreen()):
                        Get.to(()=>VendorListScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email_outlined,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Chat",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    /// ------- My Inquiry -------///
                    userType !="Vendor"?SizedBox(): SizedBox(height: Get.height*0.01,),
                    userType !="Vendor"?Container():
                    InkWell(
                      onTap: (){
                        Get.to(()=>MyInquiryScreen());

                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.image_aspect_ratio,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("User Inquiry",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    /// ------- Terms & Conditions -------///
                    SizedBox(height: Get.height*0.01,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>TermScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.file_open_outlined,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Terms & Conditions",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    /// ------- CONTACT US -------///
                    SizedBox(height: Get.height*0.01,),
                    InkWell(
                      onTap: () async {
                        String email =  Uri.encodeComponent("budgetrip.27@gmail.com");
                        String subject = Uri.encodeComponent("BudgeTrip");
                        print(subject); //output: Hello%20Flutter
                        Uri mail = Uri.parse("mailto:$email?subject=$subject");
                        if (await launchUrl(mail)) {
                        //email app opened
                        }else{
                        //email app is not opened
                        }
                        // Get.to(()=>TermScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.mail,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Contact Us",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),

                    /// ------- Privacy Policy-------///
                    SizedBox(height: Get.height*0.01,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>PrivacyScreen());
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.security,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Privacy Policy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    userType =="Vendor"?SizedBox(): SizedBox(height: Get.height*0.01,),
                    userType =="Vendor"?Container():
                    /// ------- Coupon Code-------///
                    InkWell(
                      onTap: (){
                        print(profileGetController.response.value.userData!.referralcount);
                        if(int.parse(profileGetController.response.value.userData!.referralcount.toString()) > 16){
                        Get.to(()=>CoupenScreen(count: profileGetController.response.value.userData!.referralcount.toString(),));
                        }else{
                          Fluttertoast.showToast(msg: "Please More Then 15 Referred");
                        }
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.call_to_action,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Coupon Code",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                SizedBox(width: Get.width*0.04,),
                                Container(
                                  height: Get.height*0.028,
                                  width: Get.width*0.06,
                                  decoration: BoxDecoration(
                                    color: common_blue,
                                   borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(child: Text("${profileGetController.response.value.userData!.referralcount.toString()}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.white),)),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    userType =="Vendor"?SizedBox(): SizedBox(height: Get.height*0.01,),
                    userType =="Vendor"?Container():
                    /// ------- Refer -------///
                    InkWell(
                      onTap: (){
                      Get.defaultDialog(
                        title: "Refer and Earn",
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: Get.height*0.3,
                                  child: Image.asset("assests/images/rupees_photo.jpg")),
                              SizedBox(height: Get.height*0.02,),
                              Text("Coupon Will Be Generated After 15 referrals Only",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              SizedBox(height: Get.height*0.02,),
                              GestureDetector(
                                onTap: (){
                                  sharePdf();
                                },
                                child: Container(
                                  height: Get.height*0.04,
                                  width: Get.width*0.5,
                                  decoration: BoxDecoration(
                                    color: common_blue,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("Send",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              )
                            ],
                          ),
                        )
                      );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.accessibility_outlined,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                const Text("Refer and Earn",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                SizedBox(width: Get.width*0.015,),
                                profileGetController.response.value.userData!.referralcount != "0"?
                                Container(
                                  height: Get.height*0.03,
                                  width: Get.width*0.065,
                                  decoration: BoxDecoration(
                                    color: common_blue,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child:Text("${profileGetController.response.value.userData!.referralcount}",style: TextStyle(color: Colors.white,),),
                                  ),
                                ):SizedBox(),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_rounded,color: common_blue,size: Get.height*0.04,),
                              ],
                            ),
                            SizedBox(height: Get.height*0.008,),
                            Divider()],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.01,),
                    /// ---------- Delete account ----///
                    InkWell(
                      onTap: (){
                        Get.defaultDialog(
                            title: "Are You Sure Want To Delete Account?",
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap:(){
                                    Get.back();
                                  },
                                  child: Container(
                                    height: Get.height*0.04,
                                    width: Get.width*0.3,
                                    decoration: BoxDecoration(
                                      color: common_blue,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text("No",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                                Obx(() => deleteAccountController.isLoading.value?CircularProgressIndicator(color: common_blue,):
                                InkWell(
                                  onTap: (){
                                    deleteAccountController.deleteAccountCont();
                                  },
                                  child: Container(
                                    height: Get.height*0.04,
                                    width: Get.width*0.3,
                                    decoration: BoxDecoration(
                                      color: common_blue,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text("Yes",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                                )

                              ],
                            ),

                            // onConfirm: () {
                            //
                            // },
                            // onCancel: (){
                            //
                            // }
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.delete,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Delete Account",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.01,),
                    Divider(),
                    SizedBox(height: Get.height*0.01,),
                    /// ------- Logout -------///

                    InkWell(
                      onTap: (){
                        Get.defaultDialog(
                          title: "Are You Sure Want To Logout Account?",
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap:(){
                                  Get.back();
                                },
                                child: Container(
                                  height: Get.height*0.04,
                                  width: Get.width*0.3,
                                  decoration: BoxDecoration(
                                    color: common_blue,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text("Cancel",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              ),
                              Obx(() => logoutController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                              InkWell(
                                onTap: (){
                                  logoutController.logoutcont().then((value) {
                                    logOut();
                                  });

                                },
                                child: Container(
                                  height: Get.height*0.04,
                                  width: Get.width*0.3,
                                  decoration: BoxDecoration(
                                    color: common_blue,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text("Logout",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              )
                              )


                            ],
                          ),

                          // onConfirm: () {
                          //
                          // },
                          // onCancel: (){
                          //
                          // }
                        );

                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.logout_outlined,color: common_blue,size: Get.height*0.04,),
                                SizedBox(width: Get.width*0.05,),
                                Text("Logout",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.01,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      )
    );
  }
  List<String> links = [
    'https://play.google.com/store/apps/details?id=com.budgettrip.sparks',
    'https://apps.apple.com/in/app/budgetrip/id6471554749',
  ];
  String text = "The all-in-one BudgeTrip you've been waiting for!";
  Future<void> sharePdf() async {
   await Share.share(
      text +" "+"Use This Refer Code ${referCode.toString()}" + '\n' + links.join('\n'),
      subject: "Refer Code ${referCode.toString()}",
    );
  }

  logOut()async{
    print("logout");
    socialRegisterController.signOut();
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove("userid");
    sf.remove("useridOTP");
    sf.remove("loginType");
    sf.remove("MobileNo");
    sf.remove("otpStatus");
    print("LOGOUT TOKEN IS  ${sf.getString("DeviceToken")}");
    Get.offAll(()=>LoginScreen());
  }
}
