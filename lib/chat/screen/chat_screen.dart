import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/chat/controller/addChat_controller.dart';
import 'package:BudgeTrip/chat/controller/chatUser_list_controller.dart';
import 'package:BudgeTrip/chat/controller/chatVendor_list_controller.dart';
import 'package:BudgeTrip/chat/controller/getChat_controller.dart';
import 'package:BudgeTrip/chat/controller/update_chat_count_controller.dart';
import 'package:BudgeTrip/chat/screen/full_image.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatefulWidget {
  var senderId;
  var reciverId;
  var name;
  var profile;
   ChatScreen({Key? key, this.senderId,this.name,this.profile,this.reciverId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GetChatController getChatController = Get.put(GetChatController());
  AddChatController addChatController = Get.put(AddChatController());
  UpdateChatCountController updateChatCountController = Get.put(UpdateChatCountController());
  ChatVendorListController chatVendorListController = Get.put(ChatVendorListController());
  ChatUserListController chatUserListController = Get.put(ChatUserListController());
  ProfileGetController profileGetController = Get.put(ProfileGetController());
  TextEditingController sendCTC = TextEditingController();
  Timer? timer;
  var userId;
  int counter = 1;
  var pdfUrl;
  userData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      userId = sf.getString("userid");
      // print("THIS IS USER ID $userId");
    });
  }
  @override
   initState() {
    print("image path ${widget.profile}");
      addChatController.scrollToLastMessage();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      print("first${widget.senderId}");
      updateChatCountController.updateChatCountCont(widget.reciverId,widget.senderId.toString());
      userData();
      getChatController.getChatCont(widget.senderId.toString()).then((value) {
        addChatController.scrollToLastMessage();
        timer= Timer.periodic(Duration(seconds: 1), (timer) {
          profileGetController.profileGetCont1();
          print("TIMER IS $timer");
          if(profileGetController.response.value.responseCode == "0"){
            timer.cancel();
            Get.to(LoginScreen());
          }
          getChatController.getChatCont1(widget.senderId.toString());
          if(counter == 1){
            addChatController.scrollToLastMessage();
          }
          setState(() {
            counter = 2;
          });
        });

      }
      );
    });
    // getIosPath();
    super.initState();
  }
  // String? iosPath;

  String formatMessageDate(String dateString) {
    DateTime messageDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (messageDate.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (messageDate.isAtSameMomentAs(yesterday)) {
      return 'Yesterday';
    } else {
      // Format the date according to your preference
      return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
    }
  }

  Future<Uint8List> downloadPdf(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Error downloading PDF: ${response.statusCode}');
    }
  }

  String generateFileName(String url) {
    final parts = url.split('/');
    return parts[parts.length - 1]; // extract last part of the URL
  }


  Future<void> savePdfToDisk(String url) async {

    final pdfData = await downloadPdf(url);
    final directory =(await getApplicationDocumentsDirectory()).path;
    // final directory = Directory('/storage/emulated/0/Download').path;
    print((await getDownloadsDirectory())!.path);
    final fileName = generateFileName(url);
    final filePath = '$directory/$fileName'; // Use generated file name here
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
  }

  Future<void> savePdfToDiskforandroid(String url) async {

    final pdfData = await downloadPdf(url);
    // final directory = Platform.isIOS ? (await getExternalStorageDirectory())!.path : Directory('/storage/emulated/0/Download').path;
    final directory = Directory('/storage/emulated/0/Download').path;
    print((await getDownloadsDirectory())!.path);
    final fileName = generateFileName(url);
    final filePath = '$directory/$fileName'; // Use generated file name here
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        chatVendorListController.chatVendorListCont();
        chatUserListController.chatUserListCont();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height*0.080),
          child: Container(
            width: Get.width,
            height: Get.height,
            color: common_blue,
            child: Padding(
              padding:  EdgeInsets.only(left: Get.width*0.03,top: Get.height*0.03),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        chatVendorListController.chatVendorListCont();
                        chatUserListController.chatUserListCont();
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_outlined,color: Colors.white,size: 30,)),
                  SizedBox(width: Get.width*0.03,),
                  Container(
                    // width:Get.width*0.5,
                    // color: Colors.red,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            // Get.to(const EditProfileVendorScreen());
                          },
                          child:widget.profile != ""?
                          Container(
                            height: Get.height*0.060,
                            width: Get.width*0.1,
                            decoration:   BoxDecoration(
                                border: Border.all(color: Colors.white,width: 2),
                                // color: Colors.blueGrey,
                                image: DecorationImage(image: NetworkImage(widget.profile.toString()),fit: BoxFit.fill),
                                shape: BoxShape.circle
                            ),
                          ):
                          Container(
                            height: Get.height*0.060,
                            width: Get.width*0.1,
                            decoration:   BoxDecoration(
                                border: Border.all(color: Colors.white,width: 2),
                                // color: Colors.blueGrey,
                                image: DecorationImage(image: AssetImage( "assests/images/person_icon.jpg"),fit: BoxFit.fill,),
                                shape: BoxShape.circle
                            ),
                          )
                          ,
                        ),
                        SizedBox(width: Get.width*0.023,),
                        Container(
                          height: Get.height*0.050,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*0.015,),
                              Container(
                                // color: Colors.red,
                                  child: Text("${widget.name}", style: FontStyles.white_12_w700,)
                              ),
                            ],
                          ),
                        )
                      ],
                    ) ,
                  )

                ],
              ),
            ),
          )
        ),
        body: Obx(() =>getChatController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
        Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: Get.height*0.02,),
                    Expanded(
                      child:
                      getChatController.response.value.chats != null ?
                      ListView.separated(
                        controller: addChatController.scrollController,
                        shrinkWrap: true,
                        itemCount: getChatController.response.value.chats!.length,
                        itemBuilder: (BuildContext context,int index){
                          var indexx = getChatController.response.value.chats![index];
                          return indexx.message!.isNotEmpty
                              ?
                          ///-----------SHOWING TEXT MESSAGE----------///
                          Center(
                            child: Align(
                              alignment: indexx.reciverId != userId
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: indexx.reciverId != userId ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: indexx.reciverId != userId ? common_blue : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(Get.height * 0.015),
                                        child: Text(
                                          "${indexx.message}",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: indexx.reciverId != userId ? Colors.white : Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(formatMessageDate(indexx.date.toString()),style: TextStyle(color: Colors.black38),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                              : indexx.document.toString().contains(".pdf") || indexx.document.toString().contains(".doc") || indexx.document.toString().contains(".docx")
                              ? GestureDetector(
                            onTap: (){
                              print(indexx.document.toString());
                              if(Platform.isIOS){
                                print("FOR IOS CALLED!!!!!!!!!!!");
                                savePdfToDisk(indexx.document.toString()).then((value) {
                                  Fluttertoast.showToast(msg: "Document saved to downloads!!");
                                });
                              }else{
                                print("FOR ANDROID CALLED!!!!!!!!!!!");
                                savePdfToDiskforandroid(indexx.document.toString()).then((value) {
                                  Fluttertoast.showToast(msg: "Document saved to downloads!!");
                                });
                              }

                            },
                            child:
                                ///-------------SHOWIND PDF----------///
                            Align(
                              alignment: indexx.reciverId != userId ? Alignment.centerRight : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: indexx.reciverId != userId ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.6,
                                        maxHeight: Get.height * 0.07,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: common_blue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: Get.width*0.15,
                                                height: Get.height*0.05,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: common_blue,
                                                ),
                                                child: Icon(Icons.picture_as_pdf_outlined, size: 40, color: Colors.white)),
                                            SizedBox(height: 10),
                                            Text(indexx.document!.split("/").last.toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(formatMessageDate(indexx.date.toString()),style: TextStyle(color: Colors.black38),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                              :
                          ///----------SHOWING IMAGES-----------///
                          Align(
                            alignment: indexx.reciverId != userId ? Alignment.centerRight : Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => full_image(img_url: indexx.document.toString()));
                                },
                                child: Column(
                                  crossAxisAlignment: indexx.reciverId != userId ? CrossAxisAlignment.end:CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width * 0.6,
                                        maxHeight: Get.height * 0.2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: common_blue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: indexx.document.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(formatMessageDate(indexx.date.toString()),style: TextStyle(color: Colors.black38),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: Get.height*0.02,);
                      },
                      )
                          :
                      Text("No Conversation Found!"),
                    ),
                    SizedBox(height: Get.height*0.01,)
                  ],
                ),
              ),
            ),
          ],
        ),
        ),

        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: Get.height*0.1,
            width: Get.width,
            color: Colors.white,
            child:Row(
              children: [
                SizedBox(width: Get.width*0.030,),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(context: context, builder: (context) {
                      return Container(
                        width: Get.width,
                        height: Get.height*0.15,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*0.01,),
                              GestureDetector(
                                  onTap: (){
                                    openImagePicker();
                                  },
                                  child: Text("Send Photo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
                              Divider(),
                              GestureDetector(
                                  onTap: (){
                                    pickPdf();
                                  },
                                  child: Text("Send Document",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))),
                              Divider(),
                              GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17))),
                            ],
                          ),
                        ),
                      );
                    },);
                  },
                  child: Container(
                    height: Get.height*0.050,
                    width: Get.width*0.1,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 25,),
                  ),
                ),
                SizedBox(width: Get.width*0.030,),

                Container(
                  height: Get.height*0.070,
                  width: Get.width*0.8,
                  // color: Colors.red,
                  child: TextFormField(
                    controller: addChatController.msgCTC,
                    // maxLines: null,
                    // maxLength: 20,
                    autofocus: false,
                    inputFormatters: [],
                    // controller: controller,
                    obscureText: false,
                    cursorColor: Colors.blue,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400,),
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding:  EdgeInsets.all(Get.width*0.020),
                          child:Obx(() => addChatController.isLoading.value?CircularProgressIndicator(color: common_blue,):
                          InkWell(
                            onTap: (){
                              if(pickedImage == null && pickedPdf == null && addChatController.msgCTC.text.isEmpty){
                                Fluttertoast.showToast(msg: "Can't Send Empty Message!!");
                              }else{
                                addChatController.addChatCont(widget.senderId.toString(), addChatController.msgCTC.text).then((value) {
                                  addChatController.msgCTC.clear();
                                });
                              }




                              // if(addChatController.msgCTC.text.isNotEmpty && pickedImage != null && pickedPdf != null){
                              //
                              //   addChatController.addChatCont(widget.senderId.toString(), addChatController.msgCTC.text).then((value) {
                              //     addChatController.msgCTC.clear();
                              //   });
                              //
                              // }else{
                              //   Fluttertoast.showToast(msg: "Can't Send Empty Message!!");
                              // }

                              addChatController.scrollToLastMessage();
                            },
                            child: Container(
                                height: Get.height*0.030,
                                width: Get.width*0.030,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: common_blue
                                ),
                                child: Icon(Icons.arrow_upward, size: 20,color: Colors.white,)),
                          ),
                          )

                        ),
                        filled: true,
                        fillColor: const Color(0xffF2F2F2),
                        border: InputBorder.none,
                        hintText: 'Message',
                        // contentPadding: EdgeInsets.all(5),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(80)),
                        errorBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        focusedErrorBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(80),
                        )),
                  ),
                )

              ],
            ) ,
          ),
        ),
      ),
    );
  }
  // ScrollController _scrollController = ScrollController();

  File? pickedImage;
  File? pickedPdf;
  String? pdfName;
  Future<void> openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Use ImageSource.camera to capture an image
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      print("Image Path ${pickedImage}");
      addChatController.addChatCont1(widget.senderId.toString(), pickedImage).then((value) {
        print("IMAGE CONTROLLER CALLED!!!!");
        addChatController.scrollToLastMessage();
        Get.back();
        pickedImage = null;
      });
    }
    setState(() {});
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      // Handle the picked PDF file
      pickedPdf = File(result.files.single.path!);
      // Extract the PDF name without extension
      String pdfNameWithExtension = pickedPdf!.path.split('/').last; // Get the file name with extension
      pdfName = pdfNameWithExtension.replaceAll(RegExp(r'\.pdf$'), ''); // Remove the .pdf extension
      print("PDF picked: $pdfName");

      addChatController.addChatCont1(widget.senderId.toString(), pickedPdf).then((value) {
        addChatController.scrollToLastMessage();
        Get.back();
        pickedPdf = null;
      });
    }
    setState(() {});
  }

}
