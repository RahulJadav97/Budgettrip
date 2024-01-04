import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:BudgeTrip/user/screens/Transport_Mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePlan extends StatefulWidget {
  var fromLoc;
  var toLoc;
  var fromDate;
  var toDate;
  var adult;
  var child;
   ChoosePlan({Key? key,
     required this.fromLoc,
     required this.toLoc,
     required this.fromDate,
     required this.toDate,
     required this.adult,
     required this.child
   }) : super(key: key);

  @override
  State<ChoosePlan> createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {

  ProfileGetController profileGetController = Get.put(ProfileGetController());
  Timer? _timer;
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.to(LoginScreen());
      }
    });
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height*0.080),
        child: Container(
          decoration: BoxDecoration(
              color: common_blue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          ),
          child: AppBar(
            elevation: 0,
            leading: Icon(Icons.arrow_back, color: Colors.transparent,),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Get.width*0.03,right:Get.width*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*0.080,),
            Text("Choose Your Plan", style: FontStyles.black_24_w600),
            SizedBox(height: Get.height*0.080,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// birthday
            InkWell(
              onTap: (){
                Get.to(()=>TransportModeScreen(
                  fromLoc: widget.fromLoc.toString(),
                  toLoc: widget.toLoc.toString(),
                  fromDate: widget.fromDate.toString(),
                  toDate: widget.toDate.toString(),
                  adult: widget.adult.toString(),
                  plan: "Birthday Plan",
                child: widget.child.toString()
                ));
                // Get.to( BottomNavbarScreen(plan: "Birthday Plan", newIndex: 0,));
              },
              child: Container(
                width: Get.width*0.4, // Set the width of the container
                height: Get.height*0.14, // Set the height of the container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Shadow color
                      offset: Offset(0, 2), // Shadow offset (x, y)
                      blurRadius: 6, // Shadow blur radius
                      spreadRadius: 0, // Optional spread radius
                    ),
                  ],

                ),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height*0.08,
                          width: Get.width*0.1,
                          child: Image.asset("assests/images/bday.png"),
                        ),
                        Text(
                          'Birthday Plan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                ),
              ),
            ),
            SizedBox(width: Get.width*0.05,),
            /// Family plan
            InkWell(
              onTap: (){
                Get.to(()=>TransportModeScreen(
                    fromLoc: widget.fromLoc.toString(),
                    toLoc: widget.toLoc.toString(),
                    fromDate: widget.fromDate.toString(),
                    toDate: widget.toDate.toString(),
                    adult: widget.adult.toString(),
                    plan: "Family Plan",
                    child: widget.child.toString()
                ));
                // Get.to( BottomNavbarScreen(plan: "Family Plan", newIndex: 0,));
              },
              child: Container(
                width: Get.width*0.4, // Set the width of the container
                height: Get.height*0.14, // Set the height of the container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Shadow color
                      offset: Offset(0, 2), // Shadow offset (x, y)
                      blurRadius: 6, // Shadow blur radius
                      spreadRadius: 0, // Optional spread radius
                    ),
                  ],

                ),
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height*0.08,
                          width: Get.width*0.1,
                          child: Image.asset("assests/images/famillyy.png"),
                        ),
                        Text(
                          'Family Plan',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
            SizedBox(height: Get.height*0.050,) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Honeymoon
                InkWell(
                  onTap: (){
                    Get.to(()=>TransportModeScreen(
                        fromLoc: widget.fromLoc.toString(),
                        toLoc: widget.toLoc.toString(),
                        fromDate: widget.fromDate.toString(),
                        toDate: widget.toDate.toString(),
                        adult: widget.adult.toString(),
                        plan: "Honeymoon Plan",
                        child: widget.child.toString()
                    ));
                    // Get.to( BottomNavbarScreen(plan: "Honeymoon Plan", newIndex: 0,));
                  },
                  child: Container(
                    width: Get.width*0.4, // Set the width of the container
                    height: Get.height*0.14, // Set the height of the container
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // Shadow color
                          offset: Offset(0, 2), // Shadow offset (x, y)
                          blurRadius: 6, // Shadow blur radius
                          spreadRadius: 0, // Optional spread radius
                        ),
                      ],

                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height*0.08,
                              width: Get.width*0.1,
                              child: Image.asset("assests/images/couple.png"),
                            ),
                            Text(
                              'Honeymoon Plan',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(width: Get.width*0.05,),
                /// other
                InkWell(
                  onTap: (){
                    Get.to(()=>TransportModeScreen(
                        fromLoc: widget.fromLoc.toString(),
                        toLoc: widget.toLoc.toString(),
                        fromDate: widget.fromDate.toString(),
                        toDate: widget.toDate.toString(),
                        adult: widget.adult.toString(),
                        plan: "Other Plan",
                        child: widget.child.toString()
                    ));
                    // Get.to( BottomNavbarScreen(plan: "Other Plan", newIndex: 0,));
                  },
                  child: Container(
                    width: Get.width*0.4, // Set the width of the container
                    height: Get.height*0.14, // Set the height of the container
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // Shadow color
                          offset: Offset(0, 2), // Shadow offset (x, y)
                          blurRadius: 6, // Shadow blur radius
                          spreadRadius: 0, // Optional spread radius
                        ),
                      ],

                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Get.height*0.08,
                              width: Get.width*0.1,
                              child: Image.asset("assests/images/list-two-svgrepo-com 1.png"),
                            ),
                            Text(
                              'Other Plan',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
