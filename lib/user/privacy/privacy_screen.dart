
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'privacy_controller.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  PrivacyGetController privacyGetController = Get.put(PrivacyGetController());

  @override
  void initState() {
    privacyGetController.privacyGetCont();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back,color: Colors.white,),),
          title: Text("Privacy Policy",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          backgroundColor: common_blue,
        ),
        body:Obx(() => privacyGetController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
        SingleChildScrollView(
          child: Column(
            children: [
              Html(data: privacyGetController.response.value.privacyPolicy!.text)
            ],
          ),
        ),
        )

    );
  }
}
