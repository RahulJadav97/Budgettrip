import 'dart:async';

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/Common/Common_TextStyle.dart';
import 'package:BudgeTrip/auth/screen/login_screen.dart';
import 'package:BudgeTrip/user/choose%20plan/choose_plan.dart';
import 'package:BudgeTrip/user/profile/controller/profileGet_controller.dart';
import 'package:BudgeTrip/user/screens/Transport_Mode_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
var logger = Logger();

class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key,}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  ProfileGetController profileGetController = Get.put(ProfileGetController());

  TextEditingController fromLocCTC = TextEditingController();
  TextEditingController toLocCTC = TextEditingController();
  TextEditingController adultCTC = TextEditingController();
  TextEditingController childCTC = TextEditingController();
  int count = 1;
  String? selectdate ;
  var fromSel = false;
  var toSel = false;

  Timer? _timer;
  void initState() {
    _timer= Timer.periodic(Duration(seconds: 3), (timer) {
      profileGetController.profileGetCont1();
      print("search");
      if(profileGetController.response.value.responseCode == "0"){
        _timer!.cancel();
        Get.to(LoginScreen());
      }
    });
    super.initState();
  }

  Showmodelbottemsheet(){

    showModalBottomSheet(
      backgroundColor:  Color(0xff6EDA48),
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context,sState) {
              return Container(
                height: Get.height*0.2,
                width: Get.width*0.1,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          sState((){
                            if(count<=1){
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "Cant Remove");
                            }else{
                              count = count - 1;
                            }

                          });
                        });
                        logger.i("remove count${count}");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.remove, color: Colors.black, size: 30,)),
                    ),
                    Text("${count}", style: GoogleFonts.poppins(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          sState((){

                            count <=3 ?count = count + 1:Fluttertoast.showToast(
                                gravity: ToastGravity.CENTER,
                                msg: "You Cant Add More Then 4 Person");
                          });
                        });
                        logger.i("add count${count}");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Icon(Icons.add, color: Colors.black, size: 30,)),
                    )
                  ],
                ),
              );
            }
        );
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Container(
          // height: Get.height*0.7,
          width: Get.width,
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      //IMAGE CAR BUILD ETC
                      Container(
                        // color: Colors.red,
                        // height: Get.height*0.7,
                        width: Get.width,
                        child: Column(
                          children: [
                            //BUILDING IMG
                            Container(
                              height: Get.height*0.5,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage("assests/images/imgpsh_fullsize_anim.png"),fit: BoxFit.fill
                                  )
                              ),
                            ),
                            //WHITE CONT
                            Container(
                              height: Get.height*0.33,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      //GLASS CONT
                      Positioned(
                        top: Get.height*0.39,
                        child: Container(
                          width: Get.width*0.900,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(80),
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 8.0, //extend the shadow
                                offset: const Offset(
                                  0.0, // Move to right 5  horizontally
                                  0.0, // Move to bottom 5 Vertically
                                ),
                              ),
                            ],

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: Get.height*0.030,),


                              // leavinng from  container:
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    // Get.to(pick_up_Page());
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    // color: Colors.blueGrey,
                                    children: [
                                      Container(
                                        height: Get.height*0.040,
                                        width: Get.width*0.800,
                                        // color: Colors.red,
                                        child:TextFormField(
                                          controller: fromLocCTC,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(top: Get.height*0.01),
                                              prefixIcon:  Image.asset("assests/images/changed_location.png"),
                                              hintText: 'Your Location',
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.zero, // Remove any border and border radius
                                              ),
                                        )),
                                      ),
                                      SizedBox(height: Get.height*0.010,),
                                      // DIVIDER CONTAINER:
                                      Container(
                                        height: Get.height*.001,
                                        width: Get.width*0.800,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.010,),

                              //going to container:
                              InkWell(
                                onTap: (){
                                  // Get.to(drop_off_page());
                                },
                                child: Container(
                                  // color: Colors.grey,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: Get.height*0.040,
                                        width: Get.width*0.800,
                                        child:  Container(
                                          height: Get.height*0.040,
                                          width: Get.width*0.800,
                                          child:TextFormField(
                                            controller: toLocCTC,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(top: Get.height*0.01),
                                                prefixIcon:  Image.asset("assests/images/changed_location.png"),
                                                hintText: 'Your Destination',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.zero, // Remove any border and border radius
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: Get.height*0.010,),
                                      // DIVIDER CONTAINER:
                                      Container(
                                        height: Get.height*.001,
                                        width: Get.width*0.800,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: Get.height*0.020,),

                              Padding(
                                padding:  EdgeInsets.only(right: Get.width*0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// -------------- Selected From date ------------///
                                        Container(
                                          padding:  EdgeInsets.only(left: Get.width*0.015),
                                          height: Get.height*0.040,
                                          width: Get.width*0.300,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(color: Colors.transparent)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: ()async{
                                                  fromSel = true;
                                                  _fromDate(context);
                                                },
                                                child: Container(
                                                  height: Get.height*0.040,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Icon(Icons.calendar_month, size: 25,color: Color(0xff7B7B7B),),
                                                      SizedBox(width: Get.width*0.024,),
                                                      fromSel == true?
                                                      Text(selectedFromDate.toString()==""||selectedFromDate.toString()=="null"?"From":_dateFormat.format(selectedFromDate)  , style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12),):
                                                      Text("From Date",style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12))
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: Get.height*0.015,),
                                        /// -------------- Selected Adult ------------///
                                        Container(
                                          // padding:  EdgeInsets.only(right: Get.width*0.015),
                                          width: Get.width*0.3,
                                          child: TextFormField(
                                            controller: adultCTC,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:  EdgeInsets.only(right: Get.width*0.02),
                                                child: Icon(Icons.person,color: Colors.black,),
                                              ), // Add a prefix icon
                                              hintText: 'Adult',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              labelStyle: TextStyle(color: Colors.grey), // Customize the label text color
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                                borderRadius: BorderRadius.circular(12),
                                              ), // Set a background color for the TextFormField
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// -------------- Selected To date ------------///
                                        Container(
                                          height: Get.height*0.040,
                                          // width: Get.width*0.300,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(color: Colors.transparent)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: ()async{
                                                  toSel = true;
                                                  _toDate(context);
                                                },
                                                child: Container(
                                                  height: Get.height*0.070,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Icon(Icons.calendar_month, size: 25,color: Color(0xff7B7B7B),),
                                                      SizedBox(width: Get.width*0.03,),
                                                      toSel == true?
                                                      Text(selectedToDate.toString()==""||selectedToDate.toString()=="null"?"To":_dateFormat.format(selectedToDate), style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12),)
                                                          :Text("To Date",style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12))
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: Get.height*0.015,),
                                        /// -------------- Selected Child ------------///
                                        Container(
                                          width: Get.width*0.3,
                                          child: TextFormField(
                                            controller: childCTC,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                padding:  EdgeInsets.only(right: Get.width*0.045),
                                                child: Icon(Icons.person,color: Colors.black,),
                                              ), // Add a prefix icon
                                              hintText: 'Child',
                                              hintStyle: TextStyle(color: Colors.grey),
                                              labelStyle: TextStyle(color: Colors.grey), // Customize the label text color
                                              border:InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.transparent),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              // Set a background color for the TextFormField
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //  Today &Calender container:
                            //  Padding(
                            //    padding:  EdgeInsets.only(right: Get.width*0.02),
                            //    child: Row(
                            //      mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //      children: [
                            //        /// -------------- Selected From date ------------///
                            //        Container(
                            //          height: Get.height*0.040,
                            //          width: Get.width*0.300,
                            //          decoration: BoxDecoration(
                            //              color: Colors.transparent,
                            //              border: Border.all(color: Colors.transparent)
                            //          ),
                            //          child: Row(
                            //            mainAxisAlignment: MainAxisAlignment.start,
                            //            children: [
                            //              InkWell(
                            //                onTap: ()async{
                            //                  fromSel = true;
                            //                  _fromDate(context);
                            //                },
                            //                child: Container(
                            //                  height: Get.height*0.040,
                            //                  alignment: Alignment.center,
                            //                  child: Row(
                            //                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                    children: [
                            //                      Icon(Icons.calendar_month, size: 25,color: Color(0xff7B7B7B),),
                            //                      SizedBox(width: Get.width*0.03,),
                            //                      fromSel == true?
                            //                      Text(selectedFromDate.toString()==""||selectedFromDate.toString()=="null"?"From":_dateFormat.format(selectedFromDate)  , style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12),):
                            //                          Text("From Date",style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12))
                            //                    ],
                            //                  ),
                            //                ),
                            //              ),
                            //
                            //            ],
                            //          ),
                            //        ),
                            //        Container(
                            //          height: Get.height*0.040,
                            //          // width: Get.width*0.300,
                            //          decoration: BoxDecoration(
                            //              color: Colors.transparent,
                            //              border: Border.all(color: Colors.transparent)
                            //          ),
                            //          child: Row(
                            //            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //            children: [
                            //              InkWell(
                            //                onTap: ()async{
                            //                  toSel = true;
                            //                  _toDate(context);
                            //                },
                            //                child: Container(
                            //                  height: Get.height*0.070,
                            //                  alignment: Alignment.center,
                            //                  child: Row(
                            //                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //                    children: [
                            //                      Icon(Icons.calendar_month, size: 25,color: Color(0xff7B7B7B),),
                            //                      SizedBox(width: Get.width*0.03,),
                            //                      toSel == true?
                            //                      Text(selectedToDate.toString()==""||selectedToDate.toString()=="null"?"To":_dateFormat.format(selectedToDate), style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12),)
                            //                          :Text("To Date",style: GoogleFonts.poppins(color:Color(0xff000000), fontWeight: FontWeight.bold , fontSize:12))
                            //                    ],
                            //                  ),
                            //                ),
                            //              ),
                            //
                            //            ],
                            //          ),
                            //        ),
                            //      ],
                            //    ),
                            //  ),
                            //   SizedBox(height: Get.height*0.015,),
                            // /// Adult
                            // Padding(
                            //   padding:  EdgeInsets.only(left: Get.width*0.065,right: Get.width*0.02),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         width: Get.width*0.3,
                            //         child: TextFormField(
                            //           controller: adultCTC,
                            //           keyboardType: TextInputType.number,
                            //           decoration: InputDecoration(
                            //             prefixIcon: Icon(Icons.person,color: Colors.black,), // Add a prefix icon
                            //             hintText: 'Adult',
                            //             hintStyle: TextStyle(color: Colors.grey),
                            //             labelStyle: TextStyle(color: Colors.grey), // Customize the label text color
                            //             border: InputBorder.none,
                            //             enabledBorder: OutlineInputBorder(
                            //               borderSide: const BorderSide(color: Colors.transparent),
                            //               borderRadius: BorderRadius.circular(12),
                            //             ),
                            //             filled: true,
                            //             fillColor: Colors.grey[200], // Set a background color for the TextFormField
                            //           ),
                            //         ),
                            //       ),
                            //      SizedBox(width: Get.width*0.175,),
                            //       Container(
                            //         width: Get.width*0.3,
                            //         child: TextFormField(
                            //           controller: childCTC,
                            //           keyboardType: TextInputType.number,
                            //           decoration: InputDecoration(
                            //             prefixIcon: Icon(Icons.person,color: Colors.black,), // Add a prefix icon
                            //             hintText: 'Child',
                            //             hintStyle: TextStyle(color: Colors.grey),
                            //             labelStyle: TextStyle(color: Colors.grey), // Customize the label text color
                            //             border:InputBorder.none,
                            //             enabledBorder: OutlineInputBorder(
                            //               borderSide: const BorderSide(color: Colors.transparent),
                            //               borderRadius: BorderRadius.circular(12),
                            //             ),
                            //             filled: true,
                            //             fillColor: Colors.grey[200], // Set a background color for the TextFormField
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                              SizedBox(height: Get.height*0.015,),
                              // Search Container:
                              InkWell(
                                onTap: (){
                                  if(fromLocCTC.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Please Enter Your Location");
                                  }else
                                  if(toLocCTC.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Please Enter Your Destination");
                                  }else
                                  if(adultCTC.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Please Enter Your Adult");
                                  }else{
                                    Get.to(()=>ChoosePlan(
                                      fromLoc:  fromLocCTC.text,
                                      toLoc: toLocCTC.text,
                                      fromDate:selectedFromDate.toString(),
                                      toDate: selectedToDate.toString(),
                                      adult:  adultCTC.text,
                                      child:  childCTC.text,

                                    ));
                                    // Get.to( TransportModeScreen(
                                    //   fromLoc: fromLocCTC.text,
                                    //   toLoc: toLocCTC.text,
                                    //   fromDate: selectedFromDate.toString(),
                                    //   toDate: selectedToDate.toString(),
                                    //   adult: adultCTC.text,
                                    //   plan: widget.plan,
                                    //   child: childCTC.text,
                                    // ));
                                  }

                                },
                                child: Container(
                                  height: Get.height*0.060,
                                  // width: Get.width*0.8,
                                  alignment: Alignment.center,
                                  decoration:  BoxDecoration(
                                      color: common_blue,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                  ),
                                  child: Text("Search", style:  FontStyles.white_20_w500,),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //DETAILS

                  SizedBox(height: Get.height*0.050,),
                ],
              )
          ),
        )
    );
  }
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  Future<void> _fromDate(BuildContext context) async {
    // Set the initial date to today
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime.now(), // The earliest selectable date
      lastDate: DateTime(2101),  // The latest selectable date
    );

    if (pickedDate != null && pickedDate != selectedFromDate) {
      // User has selected a date
      setState(() {
        selectedFromDate = pickedDate;
        // You can use 'selectedDate' in your application as needed
      });
    }
  }

  Future<void> _toDate(BuildContext context) async {
    // Set the initial date to today or the selectedFromDate if it's later
    DateTime initialDate = selectedToDate.isAfter(selectedFromDate)
        ? selectedToDate
        : selectedFromDate;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: selectedFromDate, // Set the earliest selectable date to the selected "From" date
      lastDate: DateTime(2101),  // The latest selectable date
    );

    if (pickedDate != null && pickedDate != selectedToDate) {
      // User has selected a date
      setState(() {
        selectedToDate = pickedDate;
        print(selectedToDate);
        // You can use 'selectedDate' in your application as needed
      });
    }
  }



}



