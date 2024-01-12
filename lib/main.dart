import 'package:BudgeTrip/auth/controller/signup_controller.dart';
import 'package:http/http.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Common/Common_Color.dart';
import 'spalsh_screen.dart';
import 'utils/firebase_option.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignupController signupcont = Get.put(SignupController());
  NotificationServices notificationServices = NotificationServices();
   var fcmTocken;
  @override
  void initState() {

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print("value ${value}");
     setState(() {
       fcmTocken = value;
       signupcont.Fcmtoken = value.toString();
       print("fcmTocken ${fcmTocken}");
       fcmTokenn();
     });

    });
    super.initState();
  }

 fcmTokenn() async {
   SharedPreferences sf1 =await SharedPreferences.getInstance();
   sf1.setString("DeviceToken", fcmTocken.toString(),);
   print("FMC Token ______${fcmTocken}");
 }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Budget Trip',
      home: const SplashScreen(),
    );
  }
}


