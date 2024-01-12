import 'dart:async';
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/chat/controller/chatUser_list_controller.dart';
import 'package:BudgeTrip/chat/controller/chatVendor_list_controller.dart';
import 'package:BudgeTrip/chat/controller/count_chat_controller.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';

class VendorListScreen extends StatefulWidget {
  VendorListScreen({Key? key}) : super(key: key);

  @override
  State<VendorListScreen> createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  ChatUserListController chatUserListController = Get.put(ChatUserListController());
  ChatVendorListController chatVendorListController = Get.put(ChatVendorListController());
  CountChatController countChatController = Get.put(CountChatController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());

  Timer? _timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatVendorListController.chatVendorListCont().then((value) =>
      _timer= Timer.periodic(Duration(seconds: 3), (timer) {
        print("jjjjjjjjjjjjjj");
        profileGetController.profileGetCont1();
       setState(() {
         chatVendorListController.chatVendorListCont1().then((value) => print("jhjjbbkkkkkkk"));
       });
        if(profileGetController.response.value.responseCode == "0"){
          _timer!.cancel();
          Get.offAll(LoginScreen());
        }
      })
      );

    });



    // countChatController.countChatCont();
    super.initState();
  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // toolbarHeight: Get.height*0.12,
          leading: IconButton(onPressed: (){
            // Get.back();
          },icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,),),
          backgroundColor: common_blue,
          centerTitle: true,
          title:  Text("Chat",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),),
        ),
        body:Obx(() => chatVendorListController.isLoading.value ?Center(child: CircularProgressIndicator(color: common_blue,),):
        Column(
          children: [
            SizedBox(height: Get.height*0.01,),
            Expanded(
              child: Container(
                width: Get.width,
                height: Get.height,
                // color: common_blue,
                  decoration: BoxDecoration(
                      color: common_blue,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                  ),
                child: ListView.builder(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: chatVendorListController.response.value.chats!.length,
                    itemBuilder: (BuildContext context,int index){
                      print("lllllllllllllllllllllll");
                      var indexx = chatVendorListController.response.value.chats!;
                      print("${indexx.length}");
                      print("Count ${indexx[index].unReadMessage}");
                      return Center(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>ChatScreen(
                              reciverId:indexx[index].senderId.toString() ,
                              senderId: indexx[index].reciverDetails!.id.toString(),
                              name: indexx[index].reciverDetails!.name,
                              profile: indexx[index].reciverDetails!.profileImage,
                            ));
                          },
                          child:indexx!= []?
                          Padding(
                            padding: EdgeInsets.only(bottom: Get.height*0.01,top: Get.height*0.02),
                            child: Container(
                              width: Get.width*0.93,
                              child: Column(
                                children: [
                                  Container(
                                      height: Get.height*0.11,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                       border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(10)
                                      ),
                                      child:Column(
                                        children: [
                                          SizedBox(height: Get.height*0.02,),
                                          Padding(
                                            padding:  EdgeInsets.only(left: Get.width*0.015,right: Get.width*0.015),
                                            child: Row(
                                              children: [
                                                indexx[index].reciverDetails!.profileImage.toString() == ""?
                                                Container(
                                                  height: Get.height*0.060,
                                                  width: Get.width*0.1,
                                                  decoration:   BoxDecoration(
                                                      border: Border.all(color: Colors.black),
                                                      // color: Colors.blueGrey,
                                                      image: DecorationImage(image: AssetImage("assests/images/person_icon.jpg"),fit: BoxFit.fill,),
                                                      shape: BoxShape.circle
                                                  ),
                                                ):
                                                Container(
                                                  height: Get.height*0.050,
                                                  width: Get.width*0.11,
                                                  // child: Image.asset("assets/svg/car.png",fit: BoxFit.fill),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(image: NetworkImage(indexx[index].reciverDetails!.profileImage.toString()),fit: BoxFit.fill),
                                                      borderRadius: BorderRadius.circular(100),
                                                      border: Border.all(color: common_blue,width: 1)
                                                  ),
                                                ),
                                                SizedBox(width: Get.width*0.03,),
              
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${indexx[index].reciverDetails!.name}",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),),
                                                        Text("${indexx[index].message}",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                indexx[index].unReadMessage != 0?
                                                Container(
                                                  width: Get.width*0.06,
                                                  height: Get.height*0.06,
                                                  child: Center(
                                                    child: Text("${indexx[index].unReadMessage}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.white),),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: common_blue
                                                  ),
                                                ):
                                                Container(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  SizedBox(height: Get.height*0.002,)
                                ],
                              ),
                            ),
                          ):Center(child: Text("User List Empty"),),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        )

    );
  }
}