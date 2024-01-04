
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: Get.height*0.080),
              height: Get.height*0.250,
              width: Get.width,
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assests/images/small_blue_curve_img_.png"))
              ),
              child: Row(
                children: [
                  SizedBox(width: Get.width*0.050,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 30,)),
                  SizedBox(width: Get.width*0.220,),
                  Text("Notification", style: FontStyles.white_20_w500,)
                ],
              ),
            ),

            Positioned(
              top: Get.height*0.240,
              child: Container(
                width: Get.width,
                height: Get.height*0.8,
                color: Colors.transparent,
                padding: EdgeInsets.only(bottom: Get.height*0.050),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll){
                    overScroll.disallowIndicator();
                    return true; // Make sure to return true to prevent further handling
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount:17,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(bottom: Get.height*0.050),
                          child: Row(
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
                              SizedBox(width: Get.width*0.020,),
                              Container(
                                width: Get.width*0.750,
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: Get.width*0.750,
                                        // color: Colors.red,
                                        child: Text("Dhaval Patel", style: FontStyles.black_20_w500,)),
                                    Container(
                                        width: Get.width*0.750,
                                        // color: Colors.red,
                                        child: Text("Dhaval Patel", style: FontStyles.black_16_w300,))
                                  ],
                                ),
                              )

                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: Get.height*0.0,);
                      },),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
