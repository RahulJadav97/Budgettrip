import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../home/controller/user_inquriy_controller.dart';

class YourBudgetFortripScreen extends StatefulWidget {
  var fromLoc;
  var toLoc;
  var fromDate;
  var toDate;
  var adult;
  var child;
  var transport;
  var plan;
   YourBudgetFortripScreen({Key? key,
      this.fromLoc,
      this.toLoc,
      this.fromDate,
      this.toDate,
      this.adult,
      this.child,
      this.transport,
      this.plan,
   }) : super(key: key);

  @override
  State<YourBudgetFortripScreen> createState() => _YourBudgetFortripScreenState();
}

class _YourBudgetFortripScreenState extends State<YourBudgetFortripScreen> {

  UserInquiryController userInquiryController = Get.put(UserInquiryController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());

  Timer? _timer;
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      if(profileGetController.response.value.responseCode == "0"){
        Get.to(LoginScreen());
      }
    });
    super.initState();
  }
  TextEditingController budgetCTC = TextEditingController();
  TextEditingController messageCTC = TextEditingController();
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: common_blue,
        title: Text("Your Budget",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.02,),

                Text("Enter Your Budget For Trip", style: FontStyles.black_20_w600,),
                SizedBox(height: Get.height*0.040,),

                Text("Budget", style: FontStyles.black_20_w600,),
                SizedBox(height: Get.height*0.015,),


                CommonTextFormField(
                  keyboardType: TextInputType.number,
                  hintText: "Enter Your Budget",
                  controller: budgetCTC,
                  obscureText: false,
                  textInputFormatter: [], autofocus: false, readOnly: false,

                ),
                SizedBox(height: Get.height*0.040,),

                Text("Special Request", style: FontStyles.black_20_w600,),
                SizedBox(height: Get.height*0.015,),


               TextFormField(
                 controller: messageCTC,
                 maxLines: 5,
                 decoration: InputDecoration(
                     filled: true,
                     fillColor: Colors.transparent,
                     border: InputBorder.none,
                     hintText: "Message...",
                     // contentPadding: EdgeInsets.all(5),
                     focusedBorder: OutlineInputBorder(
                         borderSide: const BorderSide(color: const Color(0xffF2F2F2)),
                         borderRadius: BorderRadius.circular(12)),
                     errorBorder:OutlineInputBorder(
                       borderSide: const BorderSide(color:const Color(0xffF2F2F2)),
                       borderRadius: BorderRadius.circular(12),
                     ),
                     focusedErrorBorder:OutlineInputBorder(
                       borderSide: const BorderSide(color:const Color(0xffF2F2F2)),
                       borderRadius: BorderRadius.circular(12),
                     ),

                     enabledBorder: OutlineInputBorder(
                       borderSide: const BorderSide(color: const Color(0xffF2F2F2)),
                       borderRadius: BorderRadius.circular(12),
                     )),
               ),
                SizedBox(height: Get.height*0.100,),
                SizedBox(
                  height: Get.height*0.175,
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: Get.height*0.02),
                  child: Obx(() => userInquiryController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                  GestureDetector(onTap: (){
                    if(budgetCTC.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter Your Budget");
                    }else
                      if(messageCTC.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter Your Special Request");
                      }else{
                        print("Plan ${ widget.plan}");
                        print("From loc ${ widget.fromLoc}");
                        print("to Loc ${ widget.toLoc}");
                        print("fromDate ${ widget.fromDate}");
                        print("toDate ${ widget.toDate}");
                        print("adult ${ widget.adult}");
                        print("child ${ widget.child}");
                        print("transport ${ widget.transport}");
                        print("budgetCTC ${ budgetCTC.text}");
                        print("messageCTC ${ messageCTC.text}");
                        userInquiryController.userInquiryCont(
                           widget.plan != ""? widget.plan.toString():"Other Plan",
                            widget.fromLoc.toString(),
                            widget.toLoc.toString(),
                            widget.fromDate.toString(),
                            widget.toDate.toString(),
                            widget.adult.toString(),
                            widget.child.toString(),
                            widget.transport.toString(),
                            budgetCTC.text,
                            messageCTC.text
                        );
                      }

                  },
                      child: CommonBlueButton(txt: "Continue"))
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
