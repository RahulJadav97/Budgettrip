class ChatUserListModel {
  String? responseCode;
  String? message;
  String? status;
  List<Chats>? chats;

  ChatUserListModel({this.responseCode, this.message, this.status, this.chats});

  ChatUserListModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['Chats'] != null) {
      chats = <Chats>[];
      json['Chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.chats != null) {
      data['Chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String? id;
  String? senderId;
  String? reciverId;
  String? message;
  String? document;
  String? date;
  String? time;
  String? status;
  SenderDetails? senderDetails;
  int? unReadMessage;

  Chats(
      {this.id,
        this.senderId,
        this.reciverId,
        this.message,
        this.document,
        this.date,
        this.time,
        this.status,
        this.senderDetails,
        this.unReadMessage});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['SenderId'];
    reciverId = json['ReciverId'];
    message = json['Message'];
    document = json['Document'];
    date = json['Date'];
    time = json['Time'];
    status = json['Status'];
    senderDetails = json['sender_details'] != null
        ? new SenderDetails.fromJson(json['sender_details'])
        : null;
    unReadMessage = json['UnReadMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SenderId'] = this.senderId;
    data['ReciverId'] = this.reciverId;
    data['Message'] = this.message;
    data['Document'] = this.document;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Status'] = this.status;
    if (this.senderDetails != null) {
      data['sender_details'] = this.senderDetails!.toJson();
    }
    data['UnReadMessage'] = this.unReadMessage;
    return data;
  }
}

class SenderDetails {
  String? id;
  String? name;
  String? email;
  String? mobileNo;
  String? password;
  String? companyName;
  String? companyAddress;
  String? userTypeName;
  String? userType;
  String? signinType;
  String? registrationDate;
  String? profileImage;
  String? otpStatus;
  String? loginStatus;
  String? passwordOtp;
  String? fireKey;

  SenderDetails(
      {this.id,
        this.name,
        this.email,
        this.mobileNo,
        this.password,
        this.companyName,
        this.companyAddress,
        this.userTypeName,
        this.userType,
        this.signinType,
        this.registrationDate,
        this.profileImage,
        this.otpStatus,
        this.loginStatus,
        this.passwordOtp,
        this.fireKey});

  SenderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    email = json['Email'];
    mobileNo = json['MobileNo'];
    password = json['Password'];
    companyName = json['CompanyName'];
    companyAddress = json['CompanyAddress'];
    userTypeName = json['UserTypeName'];
    userType = json['UserType'];
    signinType = json['SigninType'];
    registrationDate = json['RegistrationDate'];
    profileImage = json['ProfileImage'];
    otpStatus = json['OtpStatus'];
    loginStatus = json['LoginStatus'];
    passwordOtp = json['PasswordOtp'];
    fireKey = json['fire_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['MobileNo'] = this.mobileNo;
    data['Password'] = this.password;
    data['CompanyName'] = this.companyName;
    data['CompanyAddress'] = this.companyAddress;
    data['UserTypeName'] = this.userTypeName;
    data['UserType'] = this.userType;
    data['SigninType'] = this.signinType;
    data['RegistrationDate'] = this.registrationDate;
    data['ProfileImage'] = this.profileImage;
    data['OtpStatus'] = this.otpStatus;
    data['LoginStatus'] = this.loginStatus;
    data['PasswordOtp'] = this.passwordOtp;
    data['fire_key'] = this.fireKey;
    return data;
  }
}
