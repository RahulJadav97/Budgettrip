
import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/notification/getAll_notification_controller.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:BudgeTrip/vendor/notification/venfornotification_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'controller/vendor_inquiry_get_controller.dart';
import 'vendor_details_screen.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  VendorInquiryGetController vendorInquiryGetController =Get.put(VendorInquiryGetController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());
  GetAllNotificationController getAllNotificationController = Get.put(GetAllNotificationController());

  DateTime currentDate = DateTime.now();
    DateTime previousDate = DateTime.now().subtract(Duration(days: 1));
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllNotificationController.getAllNotificationCont();
      vendorInquiryGetController.vendorInquiryGetCont();
      profileGetController.profileGetCont();
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
    print("currentDate $currentDate ");
    return Obx(() => vendorInquiryGetController.isLoading.value||profileGetController.isLoading.value||getAllNotificationController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
    Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.add,color: Colors.transparent,),
          centerTitle: true,
          backgroundColor: common_blue,
          /// ----------- profile ------------///
          // leading:  profileGetController.response.value.userData!.profileImage!.isNotEmpty?
          // Padding(
          //   padding:  EdgeInsets.all(Get.height*0.006),
          //   child: Container(
          //     height: Get.height*0.040,
          //     width: Get.width*0.2,
          //     decoration: BoxDecoration(
          //         border:Border.all(color: Colors.white,width: 2) ,
          //         // color: Colors.blueGrey,
          //         image: DecorationImage(image: NetworkImage(profileGetController.response.value.userData!.profileImage.toString()),fit: BoxFit.fill),
          //         shape: BoxShape.circle
          //     ),
          //   ),
          // ):
          // Padding(
          //   padding:  EdgeInsets.all(Get.height*0.006),
          //   child: Container(
          //     height: Get.height*0.040,
          //     width: Get.width*0.2,
          //
          //     decoration: BoxDecoration(
          //       // border:Border.all(color: Colors.white,width: 2) ,
          //       color: Colors.transparent,
          //       image: DecorationImage(image: AssetImage("assests/images/persion_blue_img.png"),fit: BoxFit.fill),
          //       // shape: BoxShape.circle
          //     ),
          //   ),
          // ),
          /// ------------- titlt ---------- ///
          // title: Text("${profileGetController.response.value.userData!.name}", style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
          title: Text("User Inquiry", style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),

          actions: [
            Padding(
              padding:  EdgeInsets.only(right: Get.width*0.023,top: Get.height*0.002),
              child: Center(
                child: Container(
                  // color: Colors.red,
                  child: InkWell(
                      onTap: (){
                        getAllNotificationController.getAllNotificationCont();
                        Get.to( VendorNotificationScreen());
                      },
                      child:
                      Stack(
                        children: [
                          Icon(Icons.notifications_active_outlined, color: Colors.white,size: 30,),
                          getAllNotificationController.response.value.notificationcount !=0?
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(color: common_blue),
                                color: Colors.white, // Background color for the notification count
                                shape: BoxShape.circle, // You can change the shape as needed
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16, // Minimum width for the count indicator
                                minHeight: 16, // Minimum height for the count indicator
                              ),
                              child: Center(
                                child: Text(
                                  '${getAllNotificationController.response.value.notificationcount}',
                                  style: TextStyle(
                                    color: common_blue, // Text color for the count
                                    fontSize:8, // Text font size
                                  ),
                                ),
                              ),
                            ),
                          ):
                          Container(),
                        ],
                      )
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: Get.height*0.01,),
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                // color: common_blue,
                decoration: BoxDecoration(
                  color: common_blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll){
                    overScroll.disallowIndicator();
                    return true; // Make sure to return true to prevent further handling
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 12.0),
                      shrinkWrap: true,
                      itemCount:vendorInquiryGetController.response.value.inquiry!.length,
                      itemBuilder: (BuildContext context,int index) {
                        var indexx = vendorInquiryGetController.response.value.inquiry![index];
                       print("Company name : ${indexx.userDetails!.companyName}");
                        return InkWell(
                          onTap: (){
                            Get.to( VendorDetailsScreen(InquiryID: indexx.id.toString(),));
                          },
                          child: Center(
                            child: Container(
                              width: Get.width*0.93,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              // height: ,
                              child: Stack(
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
                                            CachedNetworkImage(
                                              imageUrl: indexx.userDetails!.profileImage.toString(),
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: Get.height * 0.070,
                                                width: Get.width * 0.2,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: common_blue,width: 2),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                                ),
                                              ),
                                              placeholder: (context, url) => Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: CupertinoActivityIndicator(color: common_blue,),
                                              ), // Optional
                                              errorWidget: (context, url, error) =>
                                                  Container(
                                                    height: Get.height*0.070,
                                                    width: Get.width*0.2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: common_blue,width: 2),
                                                        // color: Colors.blueGrey,
                                                        image: DecorationImage(image: AssetImage('assests/images/persion_blue_img.png')),
                                                        shape: BoxShape.circle
                                                    ),
                                                  ), // Optional
                                            ),


                                            Container(
                                                width: Get.width*0.6,
                                                // color: Colors.red,
                                                child: Text("${indexx.userDetails!.name}", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
                                          ],
                                        ),
                                        SizedBox(height: Get.height*0.020,),
                                        Divider(),
                                        Container(
                                          width: Get.width*0.850,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: Get.width*0.250,
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.centerLeft,

                                                  child:Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("From", style:TextStyle(fontSize: 12,color: Colors.grey)),
                                                      Text("${indexx.fromDest}", style: FontStyles.black_12_w600,)
                                                    ],
                                                  )
                                              ),
                                              Icon(CupertinoIcons.arrow_right_arrow_left,size: 22,),
                                              Container(
                                                  width: Get.width*0.250,
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.centerRight,

                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("To", style:TextStyle(fontSize: 12,color: Colors.grey)),
                                                      Text("${indexx.toDest}", style: FontStyles.black_12_w600,)
                                                    ],
                                                  ) ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Positioned(
                                      top:Get.height*0.020,
                                      right: Get.width*0.040,
                                      child: Text("${
                                      indexx.fromDate == DateFormat("dd-MM-yyyy").format(currentDate)?"Today":
                                      previousDate == indexx.fromDate?"Yesterday":
                                      indexx.fromDate.toString()
                                      }", style: FontStyles.grey_15_w400,))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: Get.height*0.020,);
                      },),
                  ),
                ),
              ),
            ),
          ],
        ),
    ));

  }


}
