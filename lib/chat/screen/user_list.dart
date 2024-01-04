import 'dart:async';
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/chat/controller/chatUser_list_controller.dart';
import 'package:BudgeTrip/chat/controller/count_chat_controller.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';

class UserListScreen extends StatefulWidget {
   UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  ChatUserListController chatUserListController = Get.put(ChatUserListController());
  CountChatController countChatController = Get.put(CountChatController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());
  Timer? _timer;

  @override
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      print("object");
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.off(LoginScreen());
      }
    });
    chatUserListController.chatUserListCont();
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
      body:Obx(() => chatUserListController.isLoading.value || countChatController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      Padding(
        padding:  EdgeInsets.only(left:Get.width*0.025,right:Get.width*0.025),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Get.height*0.02,),
             Container(
               child:  ListView.builder(
                   clipBehavior: Clip.none,
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemCount: chatUserListController.response.value.chats!.length,
                   itemBuilder: (BuildContext context,int index){
                     var indexx = chatUserListController.response.value.chats!;
                     print(indexx[index].senderDetails!.profileImage.toString());
                     // print("${indexx.last.message}");
                     // print("Countffffff ${indexx[index].message}");
                     // print("hfsuibfiub");
                     return Center(
                       child: GestureDetector(
                         onTap: (){

                           Get.to(()=>ChatScreen(
                             reciverId: indexx[index].reciverId.toString(),
                             senderId: indexx[index].senderId.toString(),
                             name: indexx[index].senderDetails!.companyName,
                             profile: indexx[index].senderDetails!.profileImage,
                           ));
                         },
                         child:indexx!= [] || indexx != null?
                         Container(
                           child: Column(
                             children: [
                               Container(
                                   height: Get.height*0.11,
                                   decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(15),
                                       border: Border.all(color: common_blue)
                                     // borderRadius: BorderRadius.circular(10)
                                   ),
                                   child:Column(
                                     children: [
                                       SizedBox(height: Get.height*0.02,),
                                       // Align(
                                       //     alignment: Alignment.topRight,
                                       //     child: Padding(
                                       //       padding: const EdgeInsets.only(right: 8.0,top: 8),
                                       //       child: Text("30 Min. ago"),
                                       //     )),
                                       Padding(
                                         padding:  EdgeInsets.only(left: Get.width*0.015,right: Get.width*0.015),
                                         child: Row(
                                           children: [
                                             indexx[index].senderDetails!.profileImage.toString() == ""?
                                             Container(
                                               height: Get.height*0.060,
                                               width: Get.width*0.1,
                                               decoration:   BoxDecoration(
                                                   border: Border.all(color: Colors.white,width: 2),
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
                                                   image: DecorationImage(image:NetworkImage(indexx[index].senderDetails!.profileImage.toString()),fit: BoxFit.fill),
                                                   borderRadius: BorderRadius.circular(100),
                                                   border: Border.all(color: common_blue,width: 1)
                                               ),
                                             ),
                                             SizedBox(width: Get.width*0.03,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text("${indexx[index].senderDetails!.companyName}",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),),
                                                 Container(
                                                     width: Get.width*0.7,
                                                     child: Text(indexx[index].message.toString(),style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.grey,overflow: TextOverflow.ellipsis),))
                                               ],
                                             ),Spacer(),
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
                                             Container()
                                           ],
                                         ),
                                       ),
                                     ],
                                   )
                               ),
                               SizedBox(height: Get.height*0.002,)
                             ],
                           ),
                         ):Center(child: Text("User List Empty"),),
                       ),
                     );
                   }),
             )

            ],
          ),
        ),
      ),
      )

    );
  }
}