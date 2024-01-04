class TermModel {
  String? responseCode;
  String? message;
  TermsConditions? termsConditions;
  String? status;

  TermModel(
      {this.responseCode, this.message, this.termsConditions, this.status});

  TermModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    termsConditions = json['terms_conditions'] != null
        ? new TermsConditions.fromJson(json['terms_conditions'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.termsConditions != null) {
      data['terms_conditions'] = this.termsConditions!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class TermsConditions {
  String? id;
  String? text;

  TermsConditions({this.id, this.text});

  TermsConditions.fromJson(Map<String, dynamic> json) {
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
