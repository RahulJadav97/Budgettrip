class UserInquiryGetModel {
  String? responseCode;
  String? message;
  String? status;
  List<Inquiry>? inquiry;

  UserInquiryGetModel(
      {this.responseCode, this.message, this.status, this.inquiry});

  UserInquiryGetModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['inquiry'] != null) {
      inquiry = <Inquiry>[];
      json['inquiry'].forEach((v) {
        inquiry!.add(new Inquiry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.inquiry != null) {
      data['inquiry'] = this.inquiry!.map((v) => v.toJson()).toList();
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
  String? bookingStatus;
  String? cancelStatus;

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
        this.bookingStatus,
        this.cancelStatus});

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
    bookingStatus = json['Booking_Status'];
    cancelStatus = json['Cancel_Status'];
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
    data['Booking_Status'] = this.bookingStatus;
    data['Cancel_Status'] = this.cancelStatus;
    return data;
  }
}
