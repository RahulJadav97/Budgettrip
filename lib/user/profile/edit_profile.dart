
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextFormField.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/bottombar/bottomnavbar-screen.dart';
import 'package:BudgeTrip/bottombar/vendor_bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/profileGet_controller.dart';
import 'profile_screen.dart';
import 'save_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  ProfileGetController profileGetController = Get.put(ProfileGetController());
  @override
  void initState() {
    userData();
   WidgetsBinding.instance.addPostFrameCallback((_) {
     profileGetController.profileGetCont().then((value) => getData());
   });
    super.initState();
  }
  getData(){
    setState(() {
      _mobileController.text = profileGetController.response.value.userData!.mobileNo.toString();
      _nameController.text = profileGetController.response.value.userData!.name.toString();
      _emailController.text = profileGetController.response.value.userData!.email.toString();
      _companyNameController.text = profileGetController.response.value.userData!.companyName.toString();
      _companyAddressController.text = profileGetController.response.value.userData!.companyAddress.toString();
      print("object : ${profileGetController.response.value.userData!.profileImage.toString()}");
    });
  }

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();

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
        title: Text("Edit Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
       centerTitle: true,
       backgroundColor: common_blue,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          if( profileGetController.response.value.userData!.userTypeName == "User"){
            Get.to(()=>BottomNavbarScreen(newIndex: 2,));
          }else
            {
              Get.to(()=>VenderBottomNavbarScreen(newIndex: 2, plan: "",));
            }
         
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
                alignment: Alignment.center,
                height: Get.height*0.180,
                width: Get.width,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                    color: common_blue
                ),
                child: Container(
                  height: Get.height*0.120,
                  width: Get.width*0.3,
                  decoration:  BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    // color: Colors.blueGrey,
                    image: DecorationImage(
                        image:
                        profileGetController.response.value.userData!.profileImage == ""?
                        AssetImage('assests/images/persion_blue_img.png',):
                        NetworkImage(profileGetController.response.value.userData!.profileImage.toString(),) as ImageProvider ,fit: BoxFit.cover
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: Get.height*0.02,),
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

                    userType == "Vendor"?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Company Name", style: FontStyles.black_18_w500),
                        SizedBox(height: Get.height*0.010,),
                        CommonTextFormField(
                          autofocus: true,
                          controller:_companyNameController,
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
                          maxLines: 4,
                          autofocus: true,
                          controller:_companyAddressController,
                          hintText: "Company Address",
                          textInputFormatter: [],
                          obscureText: false, readOnly: false,
                        ),
                      ],
                    ):Container(),
                    SizedBox(height: Get.height*0.02,),


                    Center(
                      child: InkWell(
                        onTap: (){
                          // Get.to( SaveProfileScreen(
                          //   name: _nameController.text,
                          //   email: _emailController.text,
                          //   mobile: _mobileController.text,
                          //   profile:
                          //   profileGetController.response.value.userData!.profileImage != ""?
                          //   profileGetController.response.value.userData!.profileImage.toString():"",
                          //   compmyName: _companyNameController.text,
                          //   compmyAddress: _companyAddressController.text
                          // )
                          // );
                        },
                        child: Container(
                            width: Get.width*0.5,
                            child: CommonBlueButton(txt: 'Edit Profile',)),
                      ),
                    ),

                    SizedBox(height: Get.height*0.050,),


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
}
