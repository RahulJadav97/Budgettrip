
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'payment_succesfull.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController _budgetController = TextEditingController();

  var Selected_method;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.1,),

                Text("Payment Method", style: FontStyles.black_20_w600,),
                SizedBox(height: Get.height*0.040,),

                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value:1 ,
                        groupValue: Selected_method,
                        onChanged: (value) {
                          setState(() {
                            Selected_method = value;
                            print('Selected_method : $Selected_method');
                          });
                        },),
                      SizedBox(width: Get.width*0.020,),

                      Icon(Icons.wallet, size: 25, color: Colors.black,),
                      SizedBox(width: Get.width*0.040,),
                      Container(
                          width: Get.width*0.5,
                          // color: Colors.blueGrey,
                          child: Text("Pay Via Wallet", style: FontStyles.black_16_w700,))
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.040,),

                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value:2 ,
                        groupValue: Selected_method,
                        onChanged: (value) {
                          setState(() {
                            Selected_method = value;
                            print('Selected_method : $Selected_method');
                          });
                        },),
                      SizedBox(width: Get.width*0.020,),

                      Icon(Icons.credit_card, size: 25, color: Colors.black,),
                      SizedBox(width: Get.width*0.040,),
                      Container(
                          width: Get.width*0.5,
                          // color: Colors.blueGrey,
                          child: Text("Debit/Credit Cardt", style: FontStyles.black_16_w700,))
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.040,),

                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value:3 ,
                        groupValue: Selected_method,
                        onChanged: (value) {
                          setState(() {
                            Selected_method = value;
                            print('Selected_method : $Selected_method');
                          });
                        },),
                      SizedBox(width: Get.width*0.028,),

                      // Icon(Icons.food_bank, size: 25, color: Colors.black,),
                      SizedBox(width: Get.width*0.040,),
                      Container(
                          width: Get.width*0.5,
                          // color: Colors.blueGrey,
                          child: Text("Pay Via Wallet", style: FontStyles.black_16_w700,))
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.040,),

                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value:4 ,
                        groupValue: Selected_method,
                        onChanged: (value) {
                          setState(() {
                            Selected_method = value;
                            print('Selected_method : $Selected_method');
                          });
                        },),
                      SizedBox(width: Get.width*0.020,),

                      Container(
                        height: Get.height*0.040,
                        width: Get.width*0.080,
                        // color: Colors.blue,
                        child: Image.asset('assests/images/upi_logo.webp', fit: BoxFit.cover,),
                      ),
                      SizedBox(width: Get.width*0.040,),
                      Container(
                          width: Get.width*0.5,
                          // color: Colors.blueGrey,
                          child: Text("UPI", style: FontStyles.black_16_w700,))
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.100,),


                Container(
                  height: Get.height*0.070,
                  child: CommonTextFormField(
                    hintText: "Apply Coupon Code",
                    prefixIcon: Padding(
                      padding:  EdgeInsets.all(Get.width*0.040),
                      child: Icon(Icons.percent_outlined),
                    ),
                      suffixIcon: Container(
                          width: Get.width*0.250,
                          child: CommonBlueButton(txt: 'Apply',)),
                      textInputFormatter: [],
                      obscureText: false,
                      autofocus: false, readOnly: false,
                  ),
                ),
                SizedBox(height: Get.height*0.100,),

                InkWell(
                    onTap: (){
                      Get.to(const PaymentSuccessfulScreen());
                    },
                    child: CommonBlueButton(txt: "Pay Now"))





              ],
            ),
          ),
        ),
      ),
    );
  }
}
