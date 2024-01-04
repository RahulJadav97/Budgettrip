
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/VendorList/vendor_list_screen.dart';
import 'package:BudgeTrip/booking_status/booking_status_controller.dart';
import 'package:BudgeTrip/cancel_status/cancel_status_controller.dart';
import 'package:BudgeTrip/user/inquiry_user/controller/userInquiry_get_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInquiryListScreen extends StatefulWidget {
  const UserInquiryListScreen({super.key});

  @override
  State<UserInquiryListScreen> createState() => _UserInquiryListScreenState();
}

class _UserInquiryListScreenState extends State<UserInquiryListScreen> {

  UserInquiryGetController userInquiryGetController = Get.put(UserInquiryGetController());
  BookingStatusController bookingStatusController = Get.put(BookingStatusController());
  CancelStatusController cancelStatusController = Get.put(CancelStatusController());

  var isIndex ;
  var cancelIndex ;
  @override
  void initState() {
    userInquiryGetController.userInquiryGetCont();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Get.back();}),
        title: Text("My Inquiry",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: common_blue,
      ),
      body:Obx(() => userInquiryGetController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      Center(
        child: Container(
          // color: Colors.red,
          width: Get.width*0.9,
          height: Get.height,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: userInquiryGetController.response.value.inquiry!.length,
              itemBuilder: (BuildContext context,int index){
                var indexx = userInquiryGetController.response.value.inquiry![index];
                return  Padding(
                  padding: EdgeInsets.only(top: Get.height*0.02),
                  child: Container(
                    // height: Get.height*0.32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: common_blue,width: 3)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(Get.width*0.022),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*0.01,),
                          /// ----------- plan ------------------///
                          Row(
                            children: [
                              Text("${indexx.plan}",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 18),),
                              Spacer(),
                              Text("${indexx.transportMode}",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: Get.height*0.01,),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("From",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text("${indexx.fromDest}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 18),),
                                ],
                              ),Spacer(),
                              // Icon(CupertinoIcons.arrow_right_arrow_left,size: 22,),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("To",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text("${indexx.toDest}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 18),),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: Get.height*0.01,),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("From Date",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text("${indexx.fromDate}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 18),),
                                ],
                              ),Spacer(),
                              // Icon(CupertinoIcons.calendar,size: 22,),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("To Date",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text("${indexx.toDate}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 18),),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: Get.height*0.01,),
                          Row(
                            children: [
                              Text("Adult :${indexx.adult}",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 18),),
                              Spacer(),
                              Text("Child :${indexx.child}",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: Get.height*0.01,),
                          Row(
                            children: [
                             Row(
                               children: [
                                 Text("Budget : ",style: TextStyle(color: common_blue,fontWeight: FontWeight.bold,fontSize: 18),),
                                 Text("₹${indexx.budget}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 18),),
                               ],
                             ),
                              Spacer(),
                              indexx.bookingStatus == "1"?
                                  Text("Booked",style: TextStyle(color: Colors.green),):
                              indexx.cancelStatus == "2"?
                              Text("Cancel",style: TextStyle(color: Colors.red),):
                                  ///  -------- book ------////
                             Row(
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     setState(() {
                                       isIndex = index;
                                       cancelIndex = index;
                                     });
                                     Get.to(()=>VendorList(inquiryId: indexx.id,));
                                     // print("${indexx.id.toString()}");
                                     // print("${indexx.userId.toString()}");
                                     // bookingStatusController.bookingStatusCont(indexx.id.toString());
                                   },
                                   child: Container(
                                     height: Get.height*0.03,
                                     width: Get.width*0.15,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         color: common_blue
                                     ),
                                     child:Center(child: Text("Book",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),)),
                                   ),
                                 ),
                                 SizedBox(width:Get.width*0.01,),
                                 /// ----- cancel ----///
                                 GestureDetector(
                                   onTap: (){
                                     Get.defaultDialog(
                                       title: "Are You Sure",
                                       content: Center(
                                         child:
                                         Obx(() => cancelStatusController.isLoading.value&& isIndex == index?Center(child: CircularProgressIndicator(color: common_blue,),):
                                         GestureDetector(
                                           onTap: (){
                                             setState(() {
                                               isIndex = index;
                                             });
                                             print("${indexx.id.toString()}");
                                             print("${indexx.userId.toString()}");
                                             cancelStatusController.cancelStatusCont(indexx.id.toString());
                                           },
                                           child: Container(
                                             height: Get.height*0.03,
                                             width: Get.width*0.15,
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(20),
                                                 color: common_blue
                                             ),
                                             child:Center(child: Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),)),
                                           ),
                                         )
                                         )
                                         ,
                                       )
                                     );
                                     setState(() {
                                       isIndex = index;
                                     });
                                     // print("${indexx.id.toString()}");
                                     // print("${indexx.userId.toString()}");
                                     // cancelStatusController.cancelStatusCont(indexx.id.toString());
                                   },
                                   child: Container(
                                     height: Get.height*0.03,
                                     width: Get.width*0.15,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         color: common_blue
                                     ),
                                     child:Center(child: Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),)),
                                   ),
                                 )
                               ],
                             )

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
      )

    );
  }
}
