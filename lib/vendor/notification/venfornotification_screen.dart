
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:BudgeTrip/notification/getAll_notification_controller.dart';
import 'package:BudgeTrip/notification/update_notification_controller.dart';
import 'package:BudgeTrip/vendor/screens/controller/vendor_inquiry_get_controller.dart';
import 'package:BudgeTrip/vendor/screens/vendor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorNotificationScreen extends StatefulWidget {
  const VendorNotificationScreen({Key? key}) : super(key: key);

  @override
  State<VendorNotificationScreen> createState() => _VendorNotificationScreenState();
}

class _VendorNotificationScreenState extends State<VendorNotificationScreen> {

  GetAllNotificationController getAllNotificationController = Get.put(GetAllNotificationController());
  UpdateNotificationController updateNotificationController = Get.put(UpdateNotificationController());
  VendorInquiryGetController vendorInquiryGetController =Get.put(VendorInquiryGetController());


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateNotificationController.updateNotificationCont();
      getAllNotificationController.getAllNotificationCont();
      vendorInquiryGetController.vendorInquiryGetCont();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          vendorInquiryGetController.vendorInquiryGetCont();
          getAllNotificationController.getAllNotificationCont();
          Get.offAll(()=>VenderBottomNavbarScreen(plan: "", newIndex: 0,));
          // Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: Colors.white,),),
        backgroundColor: common_blue,
        title: Text("Notification",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:Obx(() => vendorInquiryGetController.isLoading.value?Center(child: CircularProgressIndicator(),):
      Container(
        height: Get.height,
        width: Get.width,
        // color: Colors.red,
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(top: Get.height*0.080),
            //   height: Get.height*0.300,
            //   width: Get.width,
            //   alignment: Alignment.topLeft,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           fit: BoxFit.cover,
            //           image: AssetImage("assests/images/small_blue_curve_img_.png"))
            //   ),
            //   child: Row(
            //     children: [
            //       SizedBox(width: Get.width*0.050,),
            //       InkWell(
            //           onTap: (){
            //             vendorInquiryGetController.vendorInquiryGetCont();
            //             getAllNotificationController.getAllNotificationCont();
            //             Get.offAll(()=>VenderBottomNavbarScreen(plan: "", newIndex: 0,));
            //             // Navigator.pop(context);
            //           },
            //           child: const Icon(Icons.arrow_back, color: Colors.white, size: 30,)),
            //       SizedBox(width: Get.width*0.220,),
            //       Text("Notification", style: FontStyles.white_20_w500,)
            //     ],
            //   ),
            // ),

            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                // color: Colors.blue,
                padding: EdgeInsets.only(right: Get.width*0.050, left: Get.width*0.050),
                child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll){
                  overScroll.disallowIndicator();
                  return true; // Make sure to return true to prevent further handling
                },
                child: ListView.separated(
                  // reverse: true,
                  shrinkWrap: true,
                  itemCount:getAllNotificationController.response.value.notification!.length,
                  itemBuilder:  (BuildContext context,int index) {
                    var indexx = getAllNotificationController.response.value.notification![index];
                    return InkWell(
                      onTap: (){
                        Get.back();
                        // Get.to( VendorDetailsScreen(InquiryID: indexx.id.toString(),));
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(top: 8),
                        child: Container(
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: common_blue)
                          ),
                          padding: EdgeInsets.only(bottom: Get.height*0.020,top:Get.height*0.020 ),
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
                                width: Get.width*0.650,
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: Get.width*0.650,
                                        // color: Colors.red,
                                        child: Text("${indexx.subject}", style: FontStyles.black_18_w500,)),
                                    Container(
                                        width: Get.width*0.650,
                                        // color: Colors.red,
                                        child: Text("${indexx.message}", style: FontStyles.black_15_w400,))
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Get.height*0.0,);
                  },),
              ),
              ),
            ),
          ],
        ),
      ),
      )

    );
  }
}
