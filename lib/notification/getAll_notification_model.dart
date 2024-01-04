class GetAllNotificationModel {
  String? responseCode;
  String? message;
  String? status;
  List<Notification>? notification;
  int? notificationcount;

  GetAllNotificationModel(
      {this.responseCode,
        this.message,
        this.status,
        this.notification,
        this.notificationcount});

  GetAllNotificationModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(new Notification.fromJson(v));
      });
    }
    notificationcount = json['notificationcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.notification != null) {
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    }
    data['notificationcount'] = this.notificationcount;
    return data;
  }
}

class Notification {
  String? id;
  String? subject;
  String? message;
  String? userId;
  String? dataId;
  String? type;
  String? date;
  String? status;

  Notification(
      {this.id,
        this.subject,
        this.message,
        this.userId,
        this.dataId,
        this.type,
        this.date,
        this.status});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    message = json['message'];
    userId = json['user_id'];
    dataId = json['data_id'];
    type = json['type'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['data_id'] = this.dataId;
    data['type'] = this.type;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
