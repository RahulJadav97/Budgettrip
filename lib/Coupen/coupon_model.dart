class CouponModel {
  String? responseCode;
  String? message;
  String? status;
  CouponCode? couponCode;

  CouponModel({this.responseCode, this.message, this.status, this.couponCode});

  CouponModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    couponCode = json['coupon_code'] != null
        ? new CouponCode.fromJson(json['coupon_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.couponCode != null) {
      data['coupon_code'] = this.couponCode!.toJson();
    }
    return data;
  }
}

class CouponCode {
  String? id;
  String? title;
  String? code;
  String? description;

  CouponCode({this.id, this.title, this.code, this.description});

  CouponCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    code = json['Code'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Code'] = this.code;
    data['Description'] = this.description;
    return data;
  }
}
