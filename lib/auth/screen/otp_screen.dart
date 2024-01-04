import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/Common/common_baseurl.dart';
import 'package:BudgeTrip/Common/common_blue_button.dart';
import 'package:BudgeTrip/auth/controller/forgot_otp_controller.dart';
import 'package:BudgeTrip/auth/controller/otpVerify_controller.dart';
import 'package:BudgeTrip/resend_otp/resend_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  String? pageroute;
  String? otpRout;
  String? userID;
  String? mobile;

  OtpScreen({required this.pageroute, this.otpRout,this.userID,this.mobile}); // const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? lentered_otp;
  OtpVerifyController otpVerifyController = Get.put(OtpVerifyController());
  ForgotOtpController forgotOtpController = Get.put(ForgotOtpController());
  ResendOtpController resendOtpController = Get.put(ResendOtpController());

  TextEditingController otpCTC=TextEditingController();



  late Timer _timer;
  int _start = 0;

  void startTimer() {
    print("call");
    setState(() {
      _start = 60;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start == 0) {
            timer.cancel();
          } else {
          setState(() {
            _start--;
          });
          }
        }));
  }


  var mobileNo ;
  userData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      mobileNo = sf.getString("MobileNo");
      print("mobile no.  : ${mobileNo}");
    });
  }
  var codeValue = "";
  void listenOtp() async {
    // await SmsAutoFill().unregisterListener();
    // listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  void initState() {
    widget.pageroute=="done"?resendOtpController.resendOtpCont(widget.mobile.toString()):dummy();
    userData();
    listenOtp();
    // startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 50,
      height: Get.height*0.060,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        // color:  Color(0xff267AC9),
        border: Border.all(color: common_blue),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      // color:  Color(0xff267AC9),
      border: Border.all(color: common_blue),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        borderRadius: BorderRadius.circular(10),
        // color:  Color(0xff267AC9),
        // color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.050,),
                // image contanier
                Container(
                  // padding: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  height: Get.height*0.350,
                  color: Colors.transparent,
                  child: Image(image: AssetImage("assests/images/Enter OTP-pana 1.png"),),
                ),
                SizedBox(height: Get.height*0.030,),

                Text("OTP Verification", style:  FontStyles.black_24_w600),
                SizedBox(height: Get.height*0.020,),
                Text("We will send you a code on your mobile number please check it  and enter your code", style:FontStyles.grey_15_w400,),
                // Text("We will sent code on your mobile number", style: fontstyle.black_16px_w400,),

                SizedBox(height: Get.height*0.060,),

                // otp field:
                Center(
                  child:
                  Pinput(
                    autofillHints:[codeValue],
                    controller:otpCTC,
                    autofocus: false,
                    defaultPinTheme: defaultPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    length: 6,
                    showCursor: true,
                    onChanged: (value){
                      lentered_otp = value;
                    },
                  ),
                ),
                SizedBox(height: Get.height*0.010,),
                // Resend Otp
                Container(
                  width: Get.width*0.8,
                  // color: Colors.brown,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _start != 0?
                              Text("Sec.${_start.toString()}"):Text(""),
                              SizedBox(width: Get.width*0.08,),
                              _start == 0 ?
                              Column(
                                children: [
                                  InkWell(
                                      highlightColor: Colors.transparent,
                                      onTap: (){
                                        startTimer();
                                        print(mobileNo.toString());
                                        resendOtpController.resendOtpCont(mobileNo.toString());
                                      },
                                      child: Text("Resend OTP", style: FontStyles.blue_18_w700,)),
                                  Container(
                                    height: Get.height*0.001,
                                    width: Get.width*0.22,
                                    color:  Color(0xff267AC9),
                                  )
                                ],
                              ):SizedBox()
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),

                SizedBox(height: Get.height*0.090,),


                // continue container:
                Obx(() => otpVerifyController.isLoading.value?Center(child: CircularProgressIndicator(color: common_blue,),):
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){

                    print('lentered_otp :$lentered_otp');
                    if(lentered_otp.toString()=='' || lentered_otp.toString()==null|| lentered_otp.toString().isEmpty){
                      Fluttertoast.showToast(msg: "Please Enter Otp.....");
                    }else{

                      if(widget.otpRout == "true"){
                        forgotOtpController.forgotOtpCont(
                            widget.userID.toString(),
                            otpCTC.text
                        );
                        // otpVerifyController.otpVerifyCont1(otpVerifyController.otpCTC.text);
                      }else{
                        otpVerifyController.otpVerifyCont(
                            otpCTC.text
                        );
                      }


                    }




                  },
                  child: CommonBlueButton(txt: 'Continue',),
                ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  // var _userId;
  // userData()async{
  //   setState(() async{
  //     SharedPreferences sf3 = await SharedPreferences.getInstance();
  //     _userId = sf3.getString("useridOTP");
  //   });
  // }

  void submit() async {
    if (mobileNo.toString() == "") return;

    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "mobile_number": mobileNo.toString(),
      "app_signature_id": appSignatureID
    };
    print("sand otp code ${sendOtpData}");
  }
  void dummy(){}

}
