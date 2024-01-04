
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/chat/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class CallMessageScreen extends StatefulWidget {
  const CallMessageScreen({Key? key}) : super(key: key);

  @override
  State<CallMessageScreen> createState() => _CallMessageScreenState();
}

class _CallMessageScreenState extends State<CallMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Center(
          child: Container(
            height: Get.height*0.9,
            width: Get.width*0.950,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: Get.height*0.040),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll){
                overScroll.disallowIndicator();
                return true; // Make sure to return true to prevent further handling
              },
              child: ListView.separated(
                shrinkWrap: true,
                itemCount:17,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1 , )
                        ),
                        padding: EdgeInsets.only(bottom: Get.height*0.020, top: Get.height*0.020),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: Get.height*0.070,
                                  width: Get.width*0.2,
                                  decoration:  const BoxDecoration(
                                    // color: Colors.blueGrey,
                                      image: DecorationImage(image: AssetImage('assests/images/persion_blue_img.png')),
                                      shape: BoxShape.circle
                                  ),
                                ),

                                Container(
                                    width: Get.width*0.6,
                                    // color: Colors.red,
                                    child: Text("Dhaval Patel", style: FontStyles.black_20_w500,)),
                              ],
                            ),
                            SizedBox(height: Get.height*0.020,),
                            Container(
                              width: Get.width*0.850,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: Get.width*0.250,
                                      // color: Colors.yellow,
                                      alignment: Alignment.centerLeft,

                                      child: Text("Ahmedabad", style: FontStyles.black_12_w600,)),
                                  Transform.rotate(
                                      angle: 90*math.pi/180,
                                      child: Icon(Icons.flight_outlined, color: common_blue,size: 35,)),
                                  Container(
                                      width: Get.width*0.250,
                                      // color: Colors.yellow,
                                      alignment: Alignment.centerRight,
                                      child: Text("Dubai", style: FontStyles.black_12_w600,)),
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height*0.010,),
                            Container(
                              width: Get.width*0.850,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Get.height*0.050,
                                    width: Get.width*0.300,
                                    decoration: BoxDecoration(
                                      color: common_blue,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(Icons.call,size: 20, color: Colors.white,),
                                        Text("call", style: FontStyles.white_16_w600,)
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.to( ChatScreen());
                                    },
                                    child: Container(
                                      height: Get.height*0.050,
                                      width: Get.width*0.300,
                                      decoration: BoxDecoration(
                                          color: common_blue,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(Icons.mail,size: 20, color: Colors.white,),
                                          Text("Message", style: FontStyles.white_16_w600,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),

                      Positioned(
                          top:Get.height*0.020,
                          right: Get.width*0.040,
                          child: Text("Today", style: FontStyles.grey_15_w400,))
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: Get.height*0.020,);
                },),
            ),
          ),
        ),
      ),

    );
  }
}
