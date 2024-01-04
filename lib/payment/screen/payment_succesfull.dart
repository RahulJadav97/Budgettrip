
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessfulScreen> createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Column(
          children: [
            SizedBox(height: Get.height*0.150,),
            Container(
              height: Get.height*0.350,
              width: Get.width*0.9,
              // color: Colors.blue,
              child: Image.asset("assests/images/successful_payment.png", fit: BoxFit.contain,),
            ),
            SizedBox(height: Get.height*0.050,),

            Center(child: Text("Enjoy Your Trip !", style: FontStyles.blue_24_w600,)),
            SizedBox(height: Get.height*0.010,),

            Container(
                width: Get.width*0.7,
                alignment: Alignment.center,
                child: Text("Your Payments has been successfull",style: FontStyles.black_24_w500, textAlign: TextAlign.center,)
            ),
            SizedBox(height: Get.height*0.050,),
            
            CommonBlueButton(txt: "Go Home")

          ],
        ),
      ) ,
    );
  }
}
