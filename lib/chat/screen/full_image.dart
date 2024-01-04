import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class full_image extends StatefulWidget {
  String? img_url;


  full_image({required this.img_url});

  @override
  State<full_image> createState() => _full_imageState();
}

class _full_imageState extends State<full_image> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: common_blue,
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back,size: 30,color: Colors.white,)),
        title: Text("Image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (){
                  if(Platform.isIOS){
                    print("FOR IOS CALLED!!!!!!!!!!!");
                    savePdfToDisk(widget.img_url.toString()).then((value) {
                      Fluttertoast.showToast(msg: "Document saved to downloads!!");
                    });
                  }else{
                    print("FOR ANDROID CALLED!!!!!!!!!!!");
                    savePdfToDiskforandroid(widget.img_url.toString()).then((value) {
                      Fluttertoast.showToast(msg: "Document saved to downloads!!");
                    });
                  }
                },
                child: Icon(Icons.download,color: Colors.white,size: 25,)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(widget.img_url.toString()))
          ),
        ),
      ),
    );
  }
}
