//
// import 'package:BudgeTrip/Common/Common_Color.dart';
// import 'package:BudgeTrip/Common/Common_TextStyle.dart';
// import 'package:BudgeTrip/payment/screen/payment_method_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:path_drawing/path_drawing.dart';
//
//
// class TicketScreen extends StatefulWidget {
//   const TicketScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TicketScreen> createState() => _TicketScreenState();
// }
//
// class _TicketScreenState extends State<TicketScreen> {
//
//   oepnDilog(){
//     Get.defaultDialog(
//       title: '',
//       content: Container(
//         height: Get.height*0.2,
//         width: Get.width*0.9,
//         // color: Colors.green,
//         child:Column(
//           children: [
//             Row(
//               children: [
//                 SizedBox(width: Get.width*0.050,),
//                 Container(
//                   height: Get.height*0.1,
//                   width: Get.width*0.180,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.call, size: 25, color: common_blue,),
//                       SizedBox(height: Get.height*0.005,),
//                       Text("Call", style: FontStyles.black_10_w500,)
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//
//                 Container(
//                   height: Get.height*0.1,
//                   width: Get.width*0.180,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.mail, size: 25, color: common_blue,),
//                       SizedBox(height: Get.height*0.005,),
//                       Text("Massage", style: FontStyles.black_10_w500,)
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: Get.width*0.050,),
//               ],
//             ),
//             SizedBox(height: Get.height*0.030,),
//
//             Text('Change/Add within 2 Hours.', style: FontStyles.black_20_w500)
//           ],
//         ),
//       )
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.green,
//       body: Column(
//         children: [
//           Center(
//             child: Container(
//               height: Get.height*0.8,
//               width: Get.width*0.9,
//               color: Colors.transparent,
//               padding: EdgeInsets.only(top: Get.height*0.020, bottom: Get.height*0.020),
//               child: ListView.separated(
//                   itemCount: 7,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       // height: Get.height*0.250,
//                       width: Get.width*0.8,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         // border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(20)
//                       ),
//                       child: Column(
//                         children: [
//
//
//                           CustomPaint(
//                             painter: CurvePainter(),
//                             child: Stack(
//                               alignment: Alignment.topCenter,
//                               children: [
//                                 Container(
//                                   // color: Colors.white,
//                                   height: Get.height * 0.10,
//                                   width: Get.width * 0.6,
//                                 ),
//                                 Positioned(
//                                   top: Get.height*0.015,
//                                   left: Get.width*0.240,
//                                   child: Transform.rotate(
//                                       angle: 1.6,
//                                       child: Icon(Icons.flight, color: common_blue, size: 40,)),
//                                 )
//                               ],
//                             ),
//                           ),
//                           // SizedBox(height: Get.height*0.020,),
//
//                           Container(
//                             width: Get.width*0.7,
//                             child:
//                             Row(
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Container(
//                                       height: Get.height*0.030,
//                                       width: Get.width*0.030,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     Container(
//                                       height: Get.height*0.050,
//                                       width: Get.width*0.050,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue.withOpacity(0.5),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Spacer(),
//                                 Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Container(
//                                       height: Get.height*0.030,
//                                       width: Get.width*0.030,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     Container(
//                                       height: Get.height*0.050,
//                                       width: Get.width*0.050,
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue.withOpacity(0.5),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
// ///listview karay ane
//                           Container(
//                             width: Get.width*0.8,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Ahemdabad", style: FontStyles.black_16_w500,),
//                                     Text("DATE & TIME", style: FontStyles.grey_12_w500,),
//                                     Text("Sep 26, 11:30 PM", style: FontStyles.black_10_w500,),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text("Mumbai", style: FontStyles.black_16_w500,),
//                                     Text("FLIGHT NUMBER", style: FontStyles.grey_12_w500,),
//                                     Text("AB689", style: FontStyles.black_10_w500,),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: Get.height*0.020,),
//
//                           Container(
//                             // width: Get.width,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   height: Get.height*0.040,
//                                   width: Get.width*0.050,
//                                   decoration:  const BoxDecoration(
//                                     color: Colors.white,
//                                       // border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight:Radius.circular(100) )
//                                   ),
//                                 ),
//                                 Container(
//                                   width: Get.width*0.75,
//                                   child: const DottedLine(
//                                     direction: Axis.horizontal,
//                                     alignment: WrapAlignment.center,
//                                     lineLength: double.infinity,
//                                     lineThickness: 1.0,
//                                     dashLength: 4.0,
//                                     dashColor: Colors.grey,
//                                     // dashGradient: [Colors.red, Colors.blue],
//                                     dashRadius: 0.0,
//                                     dashGapLength: 4.0,
//                                     dashGapColor: Colors.transparent,
//                                     // dashGapGradient: [Colors.red, Colors.blue],
//                                     dashGapRadius: 0.0,
//                                   ),
//                                 ),
//
//                                 Container(
//                                   height: Get.height*0.040,
//                                   width: Get.width*0.050,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(100), bottomLeft:Radius.circular(100) )
//                                   ),
//                                 )
//
//                               ],
//                             ),
//                           ),
//
//                           Container(
//                             width: Get.width*0.8,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   height: Get.height*0.060,
//                                   width: Get.width*0.100,
//                                   decoration: BoxDecoration(
//                                     color: common_blue,
//                                     shape: BoxShape.circle
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text("Flight", style: FontStyles.white_10_w500,),
//                                 ),
//                                 Text("₹ 2500 ", style: FontStyles.blue_15_w600,)
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return SizedBox(height: Get.height*0.020,);
//                   },
//                   ),
//             ),
//           ),
//           SizedBox(height: Get.height*0.020,),
//
//           Container(
//             width: Get.width*0.9,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: (){
//                     Get.to(const PaymentMethodScreen());
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: Get.height*0.060,
//                     width: Get.width*0.4,
//                     decoration: BoxDecoration(
//                       color: common_blue,
//                       borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Text("Ok", style: FontStyles.white_20_w500,),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: (){
//                     setState(() {
//                       oepnDilog();
//                     });
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: Get.height*0.060,
//                     width: Get.width*0.4,
//                     decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(20)
//                     ),
//                     child: Text("Change", style: FontStyles.black_20_w500,),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     double h = size.height;
//     double w = size.width;
//
//     paint.color = Colors.grey;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 2;
//
//     var startPoint = Offset(0, h);
//     var controlPoint1 = Offset(w / 4, h / 4);
//     var controlPoint2 = Offset(3 * w / 4, h / 4);
//     var endPoint = Offset(w, h);
//
//     var path = Path();
//     path.moveTo(startPoint.dx, startPoint.dy);
//     path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//         controlPoint2.dy, endPoint.dx, endPoint.dy);
//     canvas.drawPath(
//         dashPath(path, dashArray: CircularIntervalList([3, 10.5])), paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class CustomClipperDesign extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     double w = size.width;
//     double h = size.height;
//
//     path.lineTo(0, h / 1.2 - 50);
//     path.quadraticBezierTo(20, h / 1.2, 80, h / 1.2);
//     path.lineTo(w, h / 1.2);
//     path.lineTo(w - 80, h / 1.2);
//     path.quadraticBezierTo(w - 20, h - 50, w, h);
//     path.lineTo(w, 0);
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
//
//
//
