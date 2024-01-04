import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/VendorList/vendor_list_controller.dart';
import 'package:BudgeTrip/confirm_booking/confirm_booking_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorList extends StatefulWidget {
  var inquiryId;
   VendorList({super.key,required this.inquiryId});


  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  VendorListController vendorListController = Get.put(VendorListController());
  ConfirmBookingStatusController confirmBookingStatusController = Get.put(ConfirmBookingStatusController());

  var isIndex ;

  @override
  void initState() {
    vendorListController.vendorListCont();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Company List",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: common_blue,
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back,color: Colors.white,),),
      ),
        body:Obx(() => vendorListController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
        Center(
            child:Container(
              height: Get.height*0.889,
              child: ListView.builder(
                shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: vendorListController.response.value.couponCode!.length,
                  itemBuilder:(BuildContext context,int index){
                    var indexx = vendorListController.response.value.couponCode![index];
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: Get.height*0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: common_blue),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CachedNetworkImage(
                                imageUrl:indexx.profileImage.toString(),
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
                              Column(
                                children: [
                                  SizedBox(height: Get.height*0.015,),
                                  Container(
                                      width: Get.width*0.5,
                                      // color: Colors.red,
                                      child: Text("${indexx.companyName == ""?"No Data Found":indexx.companyName}", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
                                  SizedBox(height: Get.height*0.008,),
                                  Container(
                                      width: Get.width*0.5,
                                      // color: Colors.red,
                                      child: Text("${indexx.companyAddress == ""?"No Data Found":indexx.companyAddress}", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                ],
                              ),
                              Obx(() => confirmBookingStatusController.isLoading.value&& isIndex == index?Center(child: CupertinoActivityIndicator(color: common_blue,),):
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isIndex = index;
                                  });
                                  confirmBookingStatusController.ConfirmBookingStatusCont(widget.inquiryId.toString(), indexx.id.toString());
                                },
                                child: Container(
                                  height: Get.height*0.03,
                                  width: Get.width*0.15,
                                  child: Center(
                                    child: Text("Book",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                  decoration: BoxDecoration(
                                      color: common_blue,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                              )
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  } ),
            )
        ),
        )

    );
  }
}
