class CountChatModel {
  String? responseCode;
  String? message;
  String? status;
  int? chats;

  CountChatModel({this.responseCode, this.message, this.status, this.chats});

  CountChatModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    chats = json['Chats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    data['Chats'] = this.chats;
    return data;
  }
}
