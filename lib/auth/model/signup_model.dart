class SignupModel {
  String? responseCode;
  String? message;
  String? status;
  UserData? userData;
  String? smsresponse;
  String? userToken;

  SignupModel(
      {this.responseCode,
        this.message,
        this.status,
        this.userData,
        this.smsresponse,
        this.userToken});

  SignupModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    smsresponse = json['smsresponse'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['smsresponse'] = this.smsresponse;
    data['user_token'] = this.userToken;
    return data;
  }
}

class UserData {
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

  UserData(
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

  UserData.fromJson(Map<String, dynamic> json) {
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
