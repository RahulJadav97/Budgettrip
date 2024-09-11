import 'dart:async';
import 'dart:io';
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/edit_profile_controller.dart';
import 'controller/profileGet_controller.dart';


class SaveProfileScreen extends StatefulWidget {
  // var name;
  // var email;
  // var mobile;
  // var profile;
  // var compmyName;
  // var compmyAddress;
   SaveProfileScreen({Key? key}) : super(key: key);
   // SaveProfileScreen({Key? key,required this.name,required this.email,required this.mobile,required this.profile,required this.compmyName,required this.compmyAddress}) : super(key: key);

  @override
  State<SaveProfileScreen> createState() => _SaveProfileScreenState();
}

class _SaveProfileScreenState extends State<SaveProfileScreen> {

  EditProfileController editProfileController =Get.put(EditProfileController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());

  FocusNode focusNode = FocusNode();
  Timer? _timer;
  @override
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      print("object2");
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.to(LoginScreen());
      }
    });
    userData();
    setState(() {
      // print(widget.profile);
      editProfileController.nameCTC.text = profileGetController.response.value.userData!.name.toString();
      editProfileController.emailCTC.text = profileGetController.response.value.userData!.email.toString();
      editProfileController.mobileCTC.text = profileGetController.response.value.userData!.mobileNo.toString();
      editProfileController.companyNameCTC.text = profileGetController.response.value.userData!.companyName.toString();
      editProfileController.companyAddressCTC.text = profileGetController.response.value.userData!.companyAddress.toString();
    });
    super.initState();
  }
  var userType;
  userData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      userType = sf.getString("userType");
      print("THIS IS USER Type $userType");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
        centerTitle: true,
        backgroundColor: common_blue,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){

          Get.back();
        }),
      ),
      body:Obx(() => profileGetController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      SingleChildScrollView(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Column(
            children: [
              Container(
                height: Get.height*0.180,
                width: Get.width,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                    color: common_blue
                ),
                alignment: Alignment.center,
                child:  CircleAvatar(
                  radius: 50,
                  backgroundColor: common_blue,
                  child: CircleAvatar(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: -4,
                          right: -11,
                          // left: 80,
                          child: IconButton(
                            onPressed: () {
                              // profile_image();
                              _pickImage();
                              print("Picked Image");
                            },
                            icon:  Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.black,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!):profileGetController.response.value.userData!.profileImage.toString() !=""?
                    NetworkImage(profileGetController.response.value.userData!.profileImage.toString())
                        : AssetImage(
                        'assests/images/person_icon.jpg')
                    as ImageProvider,
                    backgroundColor: Colors.white,
                  ),
                ),
                // child: Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Container(
                //       height: Get.height*0.300,
                //       width: Get.width,
                //       decoration:  BoxDecoration(
                //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                //           color: common_blue
                //       ),
                //     ),
                //     Positioned(
                //       top: Get.height*0.18,
                //       child: GestureDetector(
                //         onTap: (){},
                //         child:
                //       ),
                //     )
                //   ],
                // ),
              ),
              SizedBox(height: Get.height*0.05,),
              Container(
                width: Get.width*0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Name", style: FontStyles.black_18_w500),
                    SizedBox(height: Get.height*0.010,),
                    CommonTextFormField(
                      controller: editProfileController.nameCTC,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Enter Your Name";
                        }else{
                          return null;
                        }
                      },
                      hintText: "Name",
                      textInputFormatter: [],
                      obscureText: false, autofocus: true, readOnly: false,
                    ),
                    SizedBox(height: Get.height*0.030,),


                    Text("Email", style: FontStyles.black_18_w500),
                    SizedBox(height: Get.height*0.010,),
                    CommonTextFormField(
                      autofocus: true,
                      controller: editProfileController.emailCTC,
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
                      autofocus: true,
                      controller: editProfileController.mobileCTC,
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
                    SizedBox(height: Get.height*0.030,),

                    userType == "Vendor"?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Company Name", style: FontStyles.black_18_w500),
                        SizedBox(height: Get.height*0.010,),
                        CommonTextFormField(
                          autofocus: true,
                          controller:editProfileController.companyNameCTC,
                          hintText: "Company Name",
                          textInputFormatter: [],
                          obscureText: false, readOnly: false,
                        ),
                      ],
                    ):Container(),
                    SizedBox(height: Get.height*0.030,),

                    userType == "Vendor"?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Company Address", style: FontStyles.black_18_w500),
                        SizedBox(height: Get.height*0.010,),
                        CommonTextFormField(
                          maxLines: 2,
                          autofocus: true,
                          controller:editProfileController.companyAddressCTC,
                          hintText: "Company Address",
                          textInputFormatter: [],
                          obscureText: false, readOnly: false,
                        ),
                      ],
                    ):Container(),
                    SizedBox(height: Get.height*0.040,),



                    Obx(() => editProfileController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                    GestureDetector(
                      onTap: (){
                        _image != null?
                        editProfileController.editProfileCont(_image):
                        editProfileController.  editProfileCont1();
                        Get.focusScope!.unfocus();
                      },
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(bottom:Get.height*0.015 ),
                          child: Container(
                              width: Get.width*0.5,
                              child: CommonBlueButton(txt: 'Save',)),
                        ),
                      ),
                    )
                    )


                  ],
                ),
              )
            ],
          ),
        ),
      ),
      )

    );
  }
  File? _image;

  Future<void> _pickImage() async {
    print("object");
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(_image);
      });
    }
  }
}
