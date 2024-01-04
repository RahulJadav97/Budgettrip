
import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/chat/screen/chat_screen.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:BudgeTrip/vendor/screens/controller/vendor_inquiry_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/vender_inquiryGet-model.dart';
class VendorDetailsScreen extends StatefulWidget {
  var InquiryID;
   VendorDetailsScreen({super.key,required this.InquiryID});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen> {
  VendorInquiryDetailsController vendorInquiryDetailsController = Get.put(VendorInquiryDetailsController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());

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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
    print("InquiryID ${widget.InquiryID} ");
    vendorInquiryDetailsController.vendorInquiryDetailsCont(widget.InquiryID.toString());
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
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          Get.back();
        }),
        title: const Text("Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: common_blue,
      ),
      body:Obx(() => vendorInquiryDetailsController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(Get.width*0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*0.018,),
              /// user image and name
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      height: Get.height*0.090,
                        width: Get.width*0.22,
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
                          height: Get.height*0.090,
                          width: Get.width*0.22,
                          decoration: BoxDecoration(
                              border: Border.all(color: common_blue,width: 2),
                              // color: Colors.blueGrey,
                              image: DecorationImage(image: AssetImage('assests/images/persion_blue_img.png')),
                              shape: BoxShape.circle
                          ),
                        ), // Optional
                  ),
                  // Container(
                  //   height: Get.height*0.090,
                  //   width: Get.width*0.22,
                  //   decoration:BoxDecoration(
                  //       border: Border.all(color: common_blue,width: 2),
                  //       // color: Colors.blueGrey,
                  //       image: DecorationImage(image:NetworkImage(vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage.toString()), fit: BoxFit.fill ),
                  //       shape: BoxShape.circle
                  //   ),
                  // ),
                  SizedBox(width: Get.width*0.08,),
                  Container(
                      width: Get.width*0.6,
                      // color: Colors.red,
                      child: Text("${vendorInquiryDetailsController.response.value.inquiry!.userDetails!.name}", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
                ],
              ),
              SizedBox(height: Get.height*0.04,),
              Text("Plan",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
              SizedBox(height: Get.height*0.008,),
              Text("${vendorInquiryDetailsController.response.value.inquiry!.plan}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: Get.height*0.02,),
              Container(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: Get.width*0.400,
                        // color: Colors.yellow,
                        alignment: Alignment.centerLeft,

                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                            SizedBox(height: Get.height*0.008,),
                            Text("${vendorInquiryDetailsController.response.value.inquiry!.fromDest}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        )
                    ),
                    Container(
                        width: Get.width*0.400,
                        // color: Colors.yellow,
                        alignment: Alignment.centerRight,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("To",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                            SizedBox(height: Get.height*0.008,),
                            Text("${vendorInquiryDetailsController.response.value.inquiry!.toDest}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ) ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From Date",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                      SizedBox(height: Get.height*0.008,),
                      Text("${vendorInquiryDetailsController.response.value.inquiry!.fromDate}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("To Date",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                      SizedBox(height: Get.height*0.008,),
                      Text("${vendorInquiryDetailsController.response.value.inquiry!.toDate}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],),
              SizedBox(height: Get.height*0.02,),
              Text("Budget",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
              SizedBox(height: Get.height*0.008,),
              Text("₹ ${vendorInquiryDetailsController.response.value.inquiry!.budget}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: Get.height*0.01,),
              Text("Mode of Transportation",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
              SizedBox(height: Get.height*0.008,),
              Text("${vendorInquiryDetailsController.response.value.inquiry!.transportMode}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: Get.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Person",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                    SizedBox(height: Get.height*0.008,),
                    Text("${vendorInquiryDetailsController.response.value.inquiry!.adult}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Child",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
                    SizedBox(height: Get.height*0.008,),
                    Text("${vendorInquiryDetailsController.response.value.inquiry!.child}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                )
              ],),
              SizedBox(height: Get.height*0.01,),
              Text("Special Request",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:common_blue),),
              SizedBox(height: Get.height*0.008,),
              Container(
                width: Get.width,
                height: Get.height*0.08,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                      child: Text("${vendorInquiryDetailsController.response.value.inquiry!.specialRequest}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      if(vendorInquiryDetailsController.response.value.inquiry!.userDetails!.mobileNo == ""){
                        Fluttertoast.showToast(msg: "Mobile Number Does Not Exist!!");
                      }else{
                        openPhoneDialer(vendorInquiryDetailsController.response.value.inquiry!.userDetails!.mobileNo.toString());
                      }

                      // openPhoneDialer(vendorInquiryDetailsController.response.value.inquiry!.userDetails!.mobileNo.toString());
                    },
                    child: Container(
                      height: Get.height*0.06,
                      width: Get.width*0.4,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)
                      ),
                        child: Center(
                          child: Text("Call",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(()=>ChatScreen(
                                profile:vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage != ""? vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage.toString():"",
                                name: vendorInquiryDetailsController.response.value.inquiry!.userDetails!.name.toString(),
                                senderId:vendorInquiryDetailsController.response.value.inquiry!.userId.toString(),
                              ));
                      print("sender id ${vendorInquiryDetailsController.response.value.inquiry!.userId.toString()}");
                      print("sender photo ${vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage.toString()}");
                    },
                    child: Container(
                      height: Get.height*0.06,
                      width: Get.width*0.4,
                      decoration: BoxDecoration(
                          color: common_blue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: Text("Message",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              )
              // InkWell(
              //   onTap: (){
              //     Get.to(()=>ChatScreen(
              //       profile:vendorInquiryDetailsController.response.value.inquiry!.userDetails!.profileImage.toString(),
              //       name: vendorInquiryDetailsController.response.value.inquiry!.userDetails!.name.toString(),
              //       senderId:vendorInquiryDetailsController.response.value.inquiry!.userId.toString(),
              //     ));
              //   },
              //     child: CommonBlueButton(txt: "Send Message"))
            ],
          ),
        ),
      ),
      )

    );
  }

  void openPhoneDialer(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

}
