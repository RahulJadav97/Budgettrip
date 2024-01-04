
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'YourBugetForTrip_screen.dart';

class YourPlaceScreen extends StatefulWidget {
  const YourPlaceScreen({Key? key}) : super(key: key);

  @override
  State<YourPlaceScreen> createState() => _YourPlaceScreenState();
}

class _YourPlaceScreenState extends State<YourPlaceScreen> {

  bool selected= false;
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:Get.height,
        width: Get.width,
        // color: Colors.lightBlueAccent,
        child: Center(
          child: Container(
            width: Get.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.1,),

                Text("Choose Your Place", style: FontStyles.black_20_w600,),
                SizedBox(height: Get.height*0.030,),

                Container(
                  height: Get.height*0.7,
                  // width: Get.width*0.9,
                  // color: Colors.orange,
                  child:NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (glowEffect) {
                      glowEffect.disallowIndicator();
                      return true;
                    },
                    child: ListView.separated(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          width: Get.width,
                          // color: Colors.red,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // SizedBox(width: Get.width*0.020,),
                              Checkbox(
                                 checkColor: Colors.black,
                                  shape:BeveledRectangleBorder(
                                    side: BorderSide(width:Get.width*0.001,color: common_blue),

                                  ),
                                  value: selectedIndex == index ?true:false,
                                  onChanged: (value) {
                                    setState(() {
                                      print("selected");
                                      selected = !selected ;
                                      selectedIndex  = index;
                                    });
                                  },),
                              Container(
                                width: Get.width*0.7,
                                  // color: Colors.blueGrey,
                                  child: Text("Ahemdabad", style: FontStyles.black_16_w700,))
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
                        Get.to( YourBudgetFortripScreen());
                      },
                        child: CommonBlueButton(txt: "Continue")))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
