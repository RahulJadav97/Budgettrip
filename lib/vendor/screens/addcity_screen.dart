
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'vendorhome_screen.dart';

class AddCityForTripScreen extends StatefulWidget {
  const AddCityForTripScreen({Key? key}) : super(key: key);

  @override
  State<AddCityForTripScreen> createState() => _AddCityForTripScreenState();
}

class _AddCityForTripScreenState extends State<AddCityForTripScreen> {
  bool selected= false;
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:Get.height,
        width: Get.width,
        // color: Colors.lightBlueAccent,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: Get.width*0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.1,),

                  Text("Add City for Trip", style: FontStyles.black_20_w600,),
                  SizedBox(height: Get.height*0.030,),

                  Container(
                    height: Get.height*0.7,
                    // width: Get.width*0.9,
                    // color: Colors.orange,
                    child:NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverScroll) {
                        OverScroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.separated(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Get.width,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("City", style: FontStyles.black_16_w700,),
                                Row(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: Get.width*0.7,
                                      child: const CommonTextFormField(
                                        textInputFormatter: [],
                                        autofocus: false,
                                        obscureText: false, readOnly: false,
                                      ),
                                    ),
                                    SizedBox(width: Get.width*0.050,),
                                    Container(
                                      height: Get.height*0.050,
                                      width: Get.width*0.100,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.remove, color: Colors.white,),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: Get.height*0.020,);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*0.025,),

                  Center(
                      child: InkWell(
                          onTap: (){
                            Get.to(const VendorHomeScreen());
                          },
                          child: CommonBlueButton(txt: "Continue")))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
