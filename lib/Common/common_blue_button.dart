import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CommonBlueButton extends StatefulWidget {
  String? txt;

  CommonBlueButton({required this.txt});

  @override
  State<CommonBlueButton> createState() => _CommonBlueButtonState();
}

class _CommonBlueButtonState extends State<CommonBlueButton> {
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
      child: Text(widget.txt.toString(),style:FontStyles.white_20_w500,),
    );
  }
}