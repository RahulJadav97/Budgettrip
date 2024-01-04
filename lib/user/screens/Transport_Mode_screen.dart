
import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/user/Notification/notification_screen.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'YourBugetForTrip_screen.dart';
class TransportModeScreen extends StatefulWidget {
  var fromLoc;
  var toLoc;
  var fromDate;
  var toDate;
  var adult;
  var child;
  var plan;
   TransportModeScreen({
     Key? key,
     required this.fromLoc,
     required this.toLoc,
     required this.fromDate,
     required this.toDate,
     required this.adult,
     required this.child,
     required this.plan,
   }) : super(key: key);

  @override
  State<TransportModeScreen> createState() => _TransportModeScreenState();
}

class _TransportModeScreenState extends State<TransportModeScreen> {

  ProfileGetController profileGetController = Get.put(ProfileGetController());

  List images = [
    'assests/images/flight plane.png',
    'assests/images/traing_image.png',
    "assests/images/bus_img.png",
    'assests/images/persion_walk.png'
  ];

  List names = [
    "Flight",
    "Train",
    "Bus",
    "Self",
  ];
  Timer? _timer;
  @override
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.to(LoginScreen());
      }
    });
    profileGetController.profileGetCont();
    super.initState();
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
      Container(
        height: Get.height,
        width: Get.width,
        // color: Colors.blueGrey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: Get.height*0.020,),
              Container(
                padding: EdgeInsets.only(bottom: Get.height*0.02),
                height: Get.height*0.150,
                alignment: Alignment.bottomCenter,
                width: Get.width,
                color: common_blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Get.width*0.050,),
                    Container(
                      height: Get.height*0.070,
                      width: Get.width*0.4,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${profileGetController.response.value.userData!.name}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                          Text("+91 ${profileGetController.response.value.userData!.mobileNo}", style: FontStyles.white_15_w500,),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: Get.width*0.3,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                Get.to(NotificationScreen());
                              },
                              child: const Icon(Icons.notifications_active_outlined, color: Colors.white,size: 25,)),
                          profileGetController.response.value.userData!.profileImage!.isNotEmpty?
                          Container(
                            height: Get.height*0.070,
                            width: Get.width*0.2,
                            decoration:  BoxDecoration(
                                border: Border.all(color: Colors.white,width: 2),
                                // color: Colors.blueGrey,
                                image: DecorationImage(image:NetworkImage(profileGetController.response.value.userData!.profileImage.toString()),fit: BoxFit.fill),
                                shape: BoxShape.circle
                            ),
                          ):
                          Container(
                            height: Get.height*0.070,
                            width: Get.width*0.2,
                            decoration:  BoxDecoration(
                                border: Border.all(color: Colors.white,width: 2),
                                // color: Colors.blueGrey,
                                image: DecorationImage(image:AssetImage("assests/images/persion_blue_img.png"),fit: BoxFit.fill),
                                shape: BoxShape.circle
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: Get.width*0.050,),

                  ],
                ),
              ),
              SizedBox(height: Get.height*0.020,),
              // Stack(
              //   children: [
              //     Container(
              //       height: Get.height*0.300,
              //       width: Get.width,
              //       decoration:  BoxDecoration(
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image:AssetImage("assests/images/small_blue_curve_img_.png"))
              //       ),
              //     ),
              //     Positioned(
              //       top: Get.height*0.050,
              //       child:
              //     )
              //   ],
              // ),
              Container(
                height: Get.height*0.8,
                width: Get.width,
                // color: Colors.orange,
                child: Column(
                  children: [
                    // SizedBox(height: Get.height*0.020,),

                    Center(child: Text('Choose Transport Mode', style: FontStyles.black_24_w600,)),
                    SizedBox(height: Get.height*0.020,),

                    Container(
                      padding: EdgeInsets.all(Get.width*0.040),
                      height: Get.height*0.600,
                      width: Get.width,
                      // color: Colors.lightBlueAccent.withOpacity(0.3),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (glowEffect) {
                          glowEffect.disallowIndicator();
                          return true;
                        },
                        child: GridView.count(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: Get.height*0.030,
                          crossAxisSpacing: Get.height*0.020,
                          childAspectRatio: 1.0,
                          children: List.generate(4, (index) {
                            return InkWell(
                              onTap: (){
                                Get.to(()=> YourBudgetFortripScreen(
                                  fromLoc: widget.fromLoc,
                                  toLoc: widget.toLoc,
                                  fromDate: widget.fromDate,
                                  toDate: widget.toDate,
                                  adult: widget.adult,
                                  transport:names[index].toString(),
                                  plan: widget.plan,
                                  child: widget.child,
                                ));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  // color: Colors.blueGrey,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assests/images/transport_mode_bg_img.png"))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Get.height*0.080,
                                      width: Get.width*0.2,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(images[index].toString())
                                          )
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.0200,),
                                    Text(names[index].toString(), style: FontStyles.black_20_w600,)
                                  ],
                                ),
                              ),
                            );
                          }),

                        ),
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      )
      )


      );
  }
}
