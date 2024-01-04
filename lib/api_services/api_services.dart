
import 'dart:io';

import 'package:BudgeTrip/Common/common_baseurl.dart';
import 'package:BudgeTrip/Coupen/coupon_model.dart';
import 'package:BudgeTrip/VendorList/vendor_list_model.dart';
import 'package:BudgeTrip/auth/model/delete_acc_model.dart';
import 'package:BudgeTrip/auth/model/forgot_otp_model.dart';
import 'package:BudgeTrip/auth/model/forgot_pass_model.dart';
import 'package:BudgeTrip/auth/model/login_model.dart';
import 'package:BudgeTrip/auth/model/logout_model.dart';
import 'package:BudgeTrip/auth/model/newPass_model.dart';
import 'package:BudgeTrip/auth/model/signup_model.dart';
import 'package:BudgeTrip/auth/model/social_register_model.dart';
import 'package:BudgeTrip/auth/model/veifyOtp_model.dart';
import 'package:BudgeTrip/booking_status/booking_status_model.dart';
import 'package:BudgeTrip/cancel_status/cancel_status_model.dart';
import 'package:BudgeTrip/chat/model/addChat_model.dart';
import 'package:BudgeTrip/chat/model/chatUser_list_model.dart';
import 'package:BudgeTrip/chat/model/count_chat_model.dart';
import 'package:BudgeTrip/chat/model/getChat_model.dart';
import 'package:BudgeTrip/chat/model/update_chat_count_model.dart';
import 'package:BudgeTrip/chat/model/vendor_chat_list_model.dart';
import 'package:BudgeTrip/confirm_booking/confirm_booking_model.dart';
import 'package:BudgeTrip/notification/getAll_notification_model.dart';
import 'package:BudgeTrip/notification/update_notification_model.dart';
import 'package:BudgeTrip/resend_otp/resend_otp_model.dart';
import 'package:BudgeTrip/user/home/model/user_inqury_model.dart';
import 'package:BudgeTrip/user/home/screen/search_screen.dart';
import 'package:BudgeTrip/user/inquiry_user/model/userInquiry_get_model.dart';
import 'package:BudgeTrip/user/privacy/privacy_model.dart';
import 'package:BudgeTrip/user/profile/model/edit_profile_model.dart';
import 'package:BudgeTrip/user/profile/model/profileGet_model.dart';
import 'package:BudgeTrip/user/term%20and%20condition/term_model.dart';
import 'package:BudgeTrip/vendor/screens/model/vender_inquiryGet-model.dart';
import 'package:BudgeTrip/vendor/screens/model/vender_inquiry_details_model.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ApiServices {
    Dio dio = Dio();


    /// ------------------- Signup-------------------------------///
    Future<SignupModel> signup(Name, Email, MobileNo,Password,UserTypeName,CompanyName,CompanyAddress,joinreferral,fire_key) async {
      final user_form = FormData();
      SharedPreferences sf1 = await SharedPreferences.getInstance();
      print("fcmm token : ${ sf1.getString("DeviceToken")}");
      user_form.fields.add(MapEntry("Name", Name));
      user_form.fields.add(MapEntry("Email", Email));
      user_form.fields.add(MapEntry("MobileNo", MobileNo));
      user_form.fields.add(MapEntry("Password", Password));
      user_form.fields.add(MapEntry("UserTypeName", UserTypeName));
      user_form.fields.add(MapEntry("CompanyName", CompanyName));
      user_form.fields.add(MapEntry("CompanyAddress", CompanyAddress));
      user_form.fields.add(MapEntry("fire_key", fire_key));
      // user_form.fields.add(MapEntry("fire_key", sf1.getString("DeviceToken").toString()));
      user_form.fields.add(MapEntry("joinreferral", joinreferral));
      print("Api Fcm register ${sf1.getString("DeviceToken").toString()}");
      final value_user =
      await dio.post("${baseUrl}SignUp", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = SignupModel.fromJson(value_user.data);
        print("Signup api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }



    /// --------------------- Otp verify -----------------------///
    Future<VerifyOtpModel> otpVerify( otp,) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      print("user ID : ${ sharedPreferences.getString("userid")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("otp", otp));
      final value_user =
      await dio.post("${baseUrl}VerifyOtp", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = VerifyOtpModel.fromJson(value_user.data);
        print("Otp api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    /// ---------------- Login ----------------///
    Future<LoginModel> login(MobileNo, Password,fire_key) async {
      final user_form = FormData();
      SharedPreferences sf1 = await SharedPreferences.getInstance();
      print("fcmm token IS: ${ sf1.getString("DeviceToken")}");
      user_form.fields.add(MapEntry("MobileNo", MobileNo));
      user_form.fields.add(MapEntry("Password", Password));
      user_form.fields.add(MapEntry("fire_key", fire_key));
      print("Api Fcm login ${sf1.getString("DeviceToken").toString()}");

      final value_user =
      await dio.post("${baseUrl}Login", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = LoginModel.fromJson(value_user.data);
        print("Signup api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    /// ---------------- Forgot Password -----------------///
    Future<ForgotPassModel> forgot(MobileNo) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("MobileNo", MobileNo));
      final value_user =
      await dio.post("${baseUrl}ForgotPass", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = ForgotPassModel.fromJson(value_user.data);
        print("Forgot Password api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    /// ------------- New Password -------------------///
    Future<NewPasswordModel> newPassword(user_id,npassword,cpassword) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token get me : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", user_id));
      user_form.fields.add(MapEntry("npassword", npassword));
      user_form.fields.add(MapEntry("cpassword", cpassword));
      final value_user =
      await dio.post("${baseUrl}NewPassword", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = NewPasswordModel.fromJson(value_user.data);
        print("Forgot Password api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Profile get ----------///
    Future<GetProfileModel> profileGet() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}ProfileGet", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = GetProfileModel.fromJson(value_user.data);
        print("Profile api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    /// -------- userInquiry ---------- ///
    Future<UserInquiryModel> userInquiry(Plan,From,To,FromDate,ToDate,Adult,Child,TransportMode,Budget,SpecialRequest) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      print("user ID : ${ sharedPreferences.getString("userid")}");
      user_form.fields.add(MapEntry("UserId", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("Plan", Plan));
      user_form.fields.add(MapEntry("From", From));
      user_form.fields.add(MapEntry("To", To));
      user_form.fields.add(MapEntry("FromDate", FromDate));
      user_form.fields.add(MapEntry("ToDate", ToDate));
      user_form.fields.add(MapEntry("Adult", Adult));
      user_form.fields.add(MapEntry("Child", Child));
      user_form.fields.add(MapEntry("TransportMode", TransportMode));
      user_form.fields.add(MapEntry("Budget", Budget));
      user_form.fields.add(MapEntry("SpecialRequest", SpecialRequest));
      final value_user =
      await dio.post("${baseUrl}UserInquiry", data: user_form);
      if (value_user.statusCode == 200) {
        print("Call");
        final result_user = UserInquiryModel.fromJson(value_user.data);
        print("user inquiry api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    /// -------- Term ----------- ///
    Future<TermModel> term() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      final value_user =
      await dio.get("${baseUrl}TermsConditions", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = TermModel.fromJson(value_user.data);
        print("term api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    /// ------------ Privacy ----------
    Future<PrivacyModel> privacy() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      final value_user =
      await dio.get("${baseUrl}PrivacyPolicy", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = PrivacyModel.fromJson(value_user.data);
        print("Privacy Policy api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- edit Profile ----------///
    Future<EditProfileModel> editProfile(Name,Email,MobileNo,File ProfileImage,CompanyName,CompanyAddress) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("Name", Name));
      user_form.fields.add(MapEntry("Email", Email));
      user_form.fields.add(MapEntry("MobileNo", MobileNo));
      user_form.files.add(MapEntry(
          'ProfileImage',
          MultipartFile.fromFileSync(ProfileImage.path,
              filename: ProfileImage.path.split(Platform.pathSeparator).last)));
      user_form.fields.add(MapEntry("CompanyName", CompanyName));
      user_form.fields.add(MapEntry("CompanyAddress", CompanyAddress));
      final value_user =
      await dio.post("${baseUrl}EditProfile", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = EditProfileModel.fromJson(value_user.data);
        print("Profile api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- edit Profile without send img ----------///
    Future<EditProfileModel> editProfile1(Name,Email,MobileNo,CompanyName,CompanyAddress) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("Name", Name));
      user_form.fields.add(MapEntry("Email", Email));
      user_form.fields.add(MapEntry("MobileNo", MobileNo));
      user_form.fields.add(MapEntry("CompanyName", CompanyName));
      user_form.fields.add(MapEntry("CompanyAddress", CompanyAddress));
      final value_user =
      await dio.post("${baseUrl}EditProfile", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = EditProfileModel.fromJson(value_user.data);
        print("Profile api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Chat user list ----------///
    Future<ChatUserListModel> chatUserList() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("UserId", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}UserGetChatsList", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = ChatUserListModel.fromJson(value_user.data);
        print("Chat user list api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- get chat ----------///
    Future<GetChatModel> getChat(SenderId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("SenderId",SenderId ));
      user_form.fields.add(MapEntry("ReciverId", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}GetChats", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = GetChatModel.fromJson(value_user.data);
        print("Chat get api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- add chat ----------///
    Future<AddChatModel> addChat(ReciverId,Message) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      print("USER ID ISSSSSSSSSSSSSSS ${sharedPreferences.getString("userid")}");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("SenderId", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("ReciverId", ReciverId));
      user_form.fields.add(MapEntry("Message", Message));
      // user_form.files.add(MapEntry(
      //     'Document',
      //     MultipartFile.fromFileSync(Document.path,
      //         filename: Document.path.split(Platform.pathSeparator).last)));
      final value_user =
      await dio.post("${baseUrl}AddChat",data:user_form);
      if (value_user.statusCode == 200) {
        final result_user = AddChatModel.fromJson(value_user.data);
        print("Add Chat api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- add chat1 ----------///
    Future<AddChatModel> addChat1(ReciverId,Message,File Document) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("SenderId", sharedPreferences.getString("userid").toString()));
      user_form.fields.add(MapEntry("ReciverId", ReciverId));
      user_form.fields.add(MapEntry("Message", Message));
      user_form.files.add(MapEntry(
          'Document',
          MultipartFile.fromFileSync(Document.path,
              filename: Document.path.split(Platform.pathSeparator).last)));
      final value_user =
      await dio.post("${baseUrl}AddChat",data:user_form);
      if (value_user.statusCode == 200) {
        final result_user = AddChatModel.fromJson(value_user.data);
        print("Add Chat api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- get user inquiry ----------///
    Future<UserInquiryGetModel> getUserInquiry() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("UserId", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}UserInquiryGet", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = UserInquiryGetModel.fromJson(value_user.data);
        print("User Inquiry get api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- get vender inquiry ----------///
    Future<VenderInquiryGetModel> getVenderInquiry() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      final value_user =
      await dio.post("${baseUrl}VendorInquiryGet", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = VenderInquiryGetModel.fromJson(value_user.data);
        print("Vendor Inquiry get api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- get user inquiry details ----------///
    Future<VenderInquiryDetailsModel> getUserInquiryDetails(InquiryId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("InquiryId",InquiryId ));
      final value_user =
      await dio.post("${baseUrl}VendorInquiryDetails", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = VenderInquiryDetailsModel.fromJson(value_user.data);
        print("User Inquiry get api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Count chat  ----------///
    Future<CountChatModel> countChat() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("ReciverId", sharedPreferences.getString("userid").toString()));
      // user_form.fields.add(MapEntry("SenderId", SenderId));
      final value_user =
      await dio.post("${baseUrl}CountUnReadMessage", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = CountChatModel.fromJson(value_user.data);
        print("count chat api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Chat vendor list ----------///
    Future<VendorChatListModel> chatVendorList() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("UserId", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}VendorGetChatsList", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = VendorChatListModel.fromJson(value_user.data);
        print("Chat vendor list api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Get all notification list ----------///
    Future<GetAllNotificationModel> notificationList() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}GetAllNotifaction", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = GetAllNotificationModel.fromJson(value_user.data);
        print("notification list api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- update chat count ----------///
    Future<UpdateChatCountModel> updateChatCount(ReciverId,SenderId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("ReciverId", ReciverId));
      user_form.fields.add(MapEntry("SenderId", SenderId));
      final value_user =
      await dio.post("${baseUrl}UpdateMessage", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = UpdateChatCountModel.fromJson(value_user.data);
        print("update chat count api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- update notification  ----------///
    Future<UpdateNotificationModel> updateNotification() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.post("${baseUrl}UpdateNotification", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = UpdateNotificationModel.fromJson(value_user.data);
        print("update chat count api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- forgot otp  ----------///
    Future<ForgotOtpModel> forgotOtp(user_id,otp) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("user_id", user_id));
      user_form.fields.add(MapEntry("otp", otp));
      final value_user =
      await dio.post("${baseUrl}verify_otp_forgotpass", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = ForgotOtpModel.fromJson(value_user.data);
        print("verify_otp_forgotpass api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    ///  -------------- Coupon Code ----------///
    Future<CouponModel> couponCode() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      print("user token : ${ sharedPreferences.getString("usertoken")}");
      user_form.fields.add(MapEntry("UserId", sharedPreferences.getString("userid").toString()));
      final value_user =
      await dio.get("${baseUrl}GetCouponCode", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = CouponModel.fromJson(value_user.data);
        print("Coupon api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- Resend Otp ----------///
    Future<ResendOtpModel> resendOtp(MobileNo) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("MobileNo",MobileNo ));
      final value_user =
      await dio.post("${baseUrl}ResendOtp", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = ResendOtpModel.fromJson(value_user.data);
        print("Coupon api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- Booking Status ----------///
    Future<BokingStatusModel> bookingStatus(InquiryId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("InquiryId",InquiryId));
      final value_user =
      await dio.post("${baseUrl}InquiryUpdateStatus", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = BokingStatusModel.fromJson(value_user.data);
        print("Booking Status api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- Booking Status ----------///
    Future<CancelStatusModel> cancelStatus(InquiryId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("InquiryId",InquiryId));
      final value_user =
      await dio.post("${baseUrl}InquiryCancelStatus", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = CancelStatusModel.fromJson(value_user.data);
        print("Booking Status api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  -------------- Vendor List ----------///
    Future<VendorListModel> vendorList() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      final value_user =
      await dio.get("${baseUrl}GetAllVendor", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = VendorListModel.fromJson(value_user.data);
        print("Get all vendor list api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  --------------Confirm Booking Status ----------///
    Future<ConfirmBookingModel> ConfirmBookingStatus(InquiryId,VendorId) async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("InquiryId",InquiryId));
      user_form.fields.add(MapEntry("VendorId",VendorId));
      final value_user =
      await dio.post("${baseUrl}ConfrimBooking", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = ConfirmBookingModel.fromJson(value_user.data);
        print("Confirm Booking Status api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


    /// login with google
    Future<SocialRegisterModel> socialRegister(Name,Email,UserTypeName,fire_key) async {
      final user_form = FormData();
      SharedPreferences sf1 = await SharedPreferences.getInstance();
      user_form.fields.add(MapEntry("Name", Name));
      user_form.fields.add(MapEntry("Email", Email));
      user_form.fields.add(MapEntry("fire_key",fire_key));
      // user_form.fields.add(MapEntry("fire_key", sf1.getString("DeviceToken").toString()));
      user_form.fields.add(MapEntry("UserTypeName",UserTypeName ));
      // print("email$email");
      // print("email$name");
      // print("email$UserType");

      final value_user =
      await dio.post("${baseUrl}social_register", data: user_form);
      if (value_user.statusCode == 200) {
        final result = SocialRegisterModel.fromJson(value_user.data);
        logger.i(result.message);
        return result;
      } else {
        throw 'somthing went wrong';
      }
    }

    ///  --------------Delete ACCOUNT Status ----------///
    Future<DeleteAccountModel> delete_account() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("UserId",sharedPreferences.getString("userid").toString()));

      final value_user =
      await dio.post("${baseUrl}DeleteAccount", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = DeleteAccountModel.fromJson(value_user.data);
        print("Confirm Booking Status api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }

    ///  --------------Delete ACCOUNT Status ----------///
    Future<LogoutModel> logout() async {
      final user_form = FormData();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.getString("userid");
      sharedPreferences.getString("usertoken");
      dio.options.headers['authorization'] =
          sharedPreferences.getString("usertoken").toString();
      user_form.fields.add(MapEntry("UserId",sharedPreferences.getString("userid").toString()));

      final value_user =
      await dio.post("${baseUrl}LogOut", data: user_form);
      if (value_user.statusCode == 200) {
        final result_user = LogoutModel.fromJson(value_user.data);
        // print("Confirm Booking Status api services : ${result_user.message}");
        return result_user;
      }
      throw "Something went wrong";
    }


}