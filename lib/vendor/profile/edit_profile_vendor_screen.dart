
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Common/Common_TextFormField.dart';
import 'save_profile_vendor_screen.dart';

class EditProfileVendorScreen extends StatefulWidget {
  const EditProfileVendorScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileVendorScreen> createState() => _EditProfileVendorScreenState();
}

class _EditProfileVendorScreenState extends State<EditProfileVendorScreen> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _comNameController= TextEditingController();
  TextEditingController _comAddController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height*0.380,
              width: Get.width,
              // color: Colors.red,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Get.height*0.380,
                    width: Get.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assests/images/small_blue_curve_img_.png"))
                    ),
                  ),
                  Positioned(
                    top: Get.height*0.125,
                    child: Container(
                      height: Get.height*0.200,
                      width: Get.width*0.3,
                      decoration:  const BoxDecoration(
                        // color: Colors.blueGrey,
                          image: DecorationImage(image: AssetImage('assests/images/persion_blue_img.png')),
                          shape: BoxShape.circle
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: Get.width*0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Name", style: FontStyles.black_18_w500),
                  SizedBox(height: Get.height*0.010,),
                  CommonTextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Enter Your Name";
                      }else{
                        return null;
                      }
                    },
                    hintText: "Name",
                    textInputFormatter: [],
                    obscureText: false, autofocus: false, readOnly: false,
                  ),
                  SizedBox(height: Get.height*0.030,),


                  Text("Email", style: FontStyles.black_18_w500),
                  SizedBox(height: Get.height*0.010,),
                  CommonTextFormField(
                    autofocus: false,
                    controller: _emailController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Enter Email";
                      }else{
                        return null;
                      }
                    },
                    hintText: "Email",
                    textInputFormatter: [],
                    obscureText: false, readOnly: false,
                  ),
                  SizedBox(height: Get.height*0.030,),


                  Text("Mobile Number", style: FontStyles.black_18_w500),
                  SizedBox(height: Get.height*0.010,),
                  CommonTextFormField(
                    autofocus: false,
                    controller: _mobileController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Enter Mobile Number";
                      }else{
                        return null;
                      }
                    },
                    hintText: "Mobile Number",
                    textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    obscureText: false, readOnly: true,
                  ),
                  SizedBox(height: Get.height*0.050,),

                  Text("Company Name", style: FontStyles.black_18_w500),
                  SizedBox(height: Get.height*0.010,),
                  CommonTextFormField(
                    controller: _comNameController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Enter Your Company Name";
                      }else{
                        return null;
                      }
                    },
                    hintText: "Company Name",
                    textInputFormatter: [],
                    obscureText: false, autofocus: false, readOnly: false,
                  ),
                  SizedBox(height: Get.height*0.030,),


                  Text("Company Address", style: FontStyles.black_18_w500),
                  SizedBox(height: Get.height*0.010,),
                  Container(
                    height: Get.height*0.100,
                    // width: Get.width*0.8,
                    // color: Colors.red,
                    child: TextFormField(
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      inputFormatters: [],
                      controller: _comAddController,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Enter Your Company Address";
                        }else{
                          return null;
                        }
                      },
                      obscureText: false,
                      cursorColor: Colors.blue,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400,),
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding:  EdgeInsets.all(Get.width*0.020),
                            child: Container(
                                height: Get.height*0.030,
                                width: Get.width*0.030,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: common_blue
                                ),
                                child: Icon(Icons.arrow_upward, size: 20,color: Colors.white,)),
                          ),
                          filled: true,
                          fillColor: const Color(0xffF2F2F2),
                          border: InputBorder.none,
                          hintText: '406 akshat tower nr pakwan cross road Bodakdev ahmedabad',
                          // contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(12)),
                          errorBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                  )
,
                  SizedBox(height: Get.height*0.030,),

                  Center(
                    child: InkWell(
                      onTap: (){
                        Get.to(const SaveProfleVendorScreen());
                      },
                      child: Container(
                          width: Get.width*0.5,
                          child: CommonBlueButton(txt: 'Edit Profile',)),
                    ),
                  ),

                  SizedBox(height: Get.height*0.030,),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
