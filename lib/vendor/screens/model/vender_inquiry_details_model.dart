class VenderInquiryDetailsModel {
  String? responseCode;
  String? message;
  String? status;
  Inquiry? inquiry;

  VenderInquiryDetailsModel(
      {this.responseCode, this.message, this.status, this.inquiry});

  VenderInquiryDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    inquiry =
    json['inquiry'] != null ? new Inquiry.fromJson(json['inquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.inquiry != null) {
      data['inquiry'] = this.inquiry!.toJson();
    }
    return data;
  }
}

class Inquiry {
  String? id;
  String? userId;
  String? plan;
  String? fromDest;
  String? toDest;
  String? fromDate;
  String? toDate;
  String? adult;
  String? child;
  String? transportMode;
  String? budget;
  String? specialRequest;
  String? inquiryDate;
  UserDetails? userDetails;

  Inquiry(
      {this.id,
        this.userId,
        this.plan,
        this.fromDest,
        this.toDest,
        this.fromDate,
        this.toDate,
        this.adult,
        this.child,
        this.transportMode,
        this.budget,
        this.specialRequest,
        this.inquiryDate,
        this.userDetails});

  Inquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    plan = json['Plan'];
    fromDest = json['FromDest'];
    toDest = json['ToDest'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    adult = json['Adult'];
    child = json['Child'];
    transportMode = json['TransportMode'];
    budget = json['Budget'];
    specialRequest = json['SpecialRequest'];
    inquiryDate = json['InquiryDate'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['Plan'] = this.plan;
    data['FromDest'] = this.fromDest;
    data['ToDest'] = this.toDest;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['Adult'] = this.adult;
    data['Child'] = this.child;
    data['TransportMode'] = this.transportMode;
    data['Budget'] = this.budget;
    data['SpecialRequest'] = this.specialRequest;
    data['InquiryDate'] = this.inquiryDate;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
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
