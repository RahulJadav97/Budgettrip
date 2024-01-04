import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String?
  Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final String? hintText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter> textInputFormatter;

  const CommonTextFormField(
      {Key? key,
        required this.textInputFormatter,
        this.controller,
        this.maxLines,
        this.validator,
        required this.obscureText,
        required this.readOnly,
        this.keyboardType,
        this.cursorColor,
        this.hintText,
        this.contentPadding,
        this.prefixIcon,
        this.suffixIcon,
         required this.autofocus
      })
      : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height*0.060,
      // width: Get.width*0.430,
      child: TextFormField(
        focusNode:focusNode ,
        readOnly:widget.readOnly ,
        maxLines:widget.maxLines ,
        keyboardType: widget.keyboardType,
        autofocus: false,
        inputFormatters: widget.textInputFormatter,
        controller: widget.controller,
        validator: widget.validator,
        textInputAction: TextInputAction.next,
        obscureText: widget.obscureText,
        cursorColor: widget.cursorColor,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            hintText: widget.hintText,
            // contentPadding: EdgeInsets.all(5),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: const Color(0xffF2F2F2)),
                borderRadius: BorderRadius.circular(12)),
            errorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color:const Color(0xffF2F2F2)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color:const Color(0xffF2F2F2)),
              borderRadius: BorderRadius.circular(12),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: const Color(0xffF2F2F2)),
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}



