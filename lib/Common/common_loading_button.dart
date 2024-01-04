
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Common_Color.dart';
class CommonLodingButton extends StatefulWidget {
  const CommonLodingButton({Key? key}) : super(key: key);

  @override
  State<CommonLodingButton> createState() => _CommonLodingButtonState();
}

class _CommonLodingButtonState extends State<CommonLodingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.07,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: common_blue,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      width: Get.width*0.9,
      child: const CircularProgressIndicator(color: Colors.white,),
    );
  }
}