class PrivacyModel {
  String? responseCode;
  String? message;
  PrivacyPolicy? privacyPolicy;
  String? status;

  PrivacyModel(
      {this.responseCode, this.message, this.privacyPolicy, this.status});

  PrivacyModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    privacyPolicy = json['privacy_policy'] != null
        ? new PrivacyPolicy.fromJson(json['privacy_policy'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class PrivacyPolicy {
  String? id;
  String? text;

  PrivacyPolicy({this.id, this.text});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}
