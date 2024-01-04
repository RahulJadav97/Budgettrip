
import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'term_controller.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {

  TermGetController termGetController = Get.put(TermGetController());

  @override
  void initState() {
    termGetController.termGetCont();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: const Text("Terms and Conditions",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: common_blue,
      ),
      body:Obx(() => termGetController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
      SingleChildScrollView(
        child: Column(
          children: [
            Html(data: termGetController.response.value.termsConditions!.text)
          ],
        ),
      ),
      )

    );
  }
}
