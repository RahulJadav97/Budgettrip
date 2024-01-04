class VerifyOtpModel {
  String? responseCode;
  String? message;
  User? user;
  String? status;

  VerifyOtpModel({this.responseCode, this.message, this.user, this.status});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
