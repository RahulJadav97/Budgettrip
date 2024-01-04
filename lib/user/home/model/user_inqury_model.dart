class UserInquiryModel {
  String? responseCode;
  String? message;
  String? status;
  Inquiry? inquiry;

  UserInquiryModel(
      {this.responseCode, this.message, this.status, this.inquiry});

  UserInquiryModel.fromJson(Map<String, dynamic> json) {
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
  String? from;
  String? to;
  String? fromDate;
  String? toDate;
  String? adult;
  String? child;
  String? transportMode;
  String? budget;
  String? specialRequest;
  String? inquiryDate;

  Inquiry(
      {this.id,
        this.userId,
        this.plan,
        this.from,
        this.to,
        this.fromDate,
        this.toDate,
        this.adult,
        this.child,
        this.transportMode,
        this.budget,
        this.specialRequest,
        this.inquiryDate});

  Inquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    plan = json['Plan'];
    from = json['From'];
    to = json['To'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    adult = json['Adult'];
    child = json['Child'];
    transportMode = json['TransportMode'];
    budget = json['Budget'];
    specialRequest = json['SpecialRequest'];
    inquiryDate = json['InquiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['Plan'] = this.plan;
    data['From'] = this.from;
    data['To'] = this.to;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['Adult'] = this.adult;
    data['Child'] = this.child;
    data['TransportMode'] = this.transportMode;
    data['Budget'] = this.budget;
    data['SpecialRequest'] = this.specialRequest;
    data['InquiryDate'] = this.inquiryDate;
    return data;
  }
}
