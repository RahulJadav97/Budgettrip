class GetChatModel {
  String? responseCode;
  String? message;
  String? status;
  ReciverDetails? reciverDetails;
  List<Chats>? chats;

  GetChatModel(
      {this.responseCode,
        this.message,
        this.status,
        this.reciverDetails,
        this.chats});

  GetChatModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    reciverDetails = json['reciver_details'] != null
        ? new ReciverDetails.fromJson(json['reciver_details'])
        : null;
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
    if (this.reciverDetails != null) {
      data['reciver_details'] = this.reciverDetails!.toJson();
    }
    if (this.chats != null) {
      data['Chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReciverDetails {
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

  ReciverDetails(
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
        this.passwordOtp});

  ReciverDetails.fromJson(Map<String, dynamic> json) {
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

  Chats(
      {this.id,
        this.senderId,
        this.reciverId,
        this.message,
        this.document,
        this.date,
        this.time,
        this.status});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['SenderId'];
    reciverId = json['ReciverId'];
    message = json['Message'];
    document = json['Document'];
    date = json['Date'];
    time = json['Time'];
    status = json['Status'];
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
    return data;
  }
}
