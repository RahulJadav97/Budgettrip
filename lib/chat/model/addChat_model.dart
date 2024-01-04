class AddChatModel {
  String? responseCode;
  String? message;
  String? status;
  Chat? chat;

  AddChatModel({this.responseCode, this.message, this.status, this.chat});

  AddChatModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class Chat {
  String? id;
  String? senderId;
  String? reciverId;
  String? message;
  String? document;
  String? date;
  String? time;
  String? status;

  Chat(
      {this.id,
        this.senderId,
        this.reciverId,
        this.message,
        this.document,
        this.date,
        this.time,
        this.status});

  Chat.fromJson(Map<String, dynamic> json) {
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
