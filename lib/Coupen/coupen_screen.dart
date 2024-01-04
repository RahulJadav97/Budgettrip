
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coupon_controller.dart';

class CoupenScreen extends StatefulWidget {
  var count;
   CoupenScreen({super.key,required count});

  @override
  State<CoupenScreen> createState() => _CoupenScreenState();
}

class _CoupenScreenState extends State<CoupenScreen> {

  CouponController couponController = Get.put(CouponController());

  @override
  void initState() {
    couponController.couponCont();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text("Coupon Code",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: common_blue,
      ),
      body:Obx(() => couponController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assests/images/coupen.jpg"),
          SizedBox(height: Get.height*0.04,),
          Padding(
            padding: EdgeInsets.all(Get.width*0.022),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Referred Count",style: TextStyle(fontSize: 20,color:common_blue,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*0.015,),
                Text("${widget.count}",style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400),),
                SizedBox(height: Get.height*0.04,),
                Text("Title",style: TextStyle(fontSize: 20,color:common_blue,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*0.015,),
                Text("${couponController.response.value.couponCode!.title}",style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400),),
                SizedBox(height: Get.height*0.04,),
                Text("Coupon Code",style: TextStyle(fontSize: 20,color:common_blue,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*0.015,),
                Text("${couponController.response.value.couponCode!.code}",style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400),),
                SizedBox(height: Get.height*0.04,),
                Text("Description",style: TextStyle(fontSize: 20,color:common_blue,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*0.015,),
                Text("${couponController.response.value.couponCode!.description}",style: TextStyle(fontSize: 15,color:Colors.black,fontWeight: FontWeight.w400),),
              ],
            ),
          )
        ],
      ),
      )

    );
  }
}
