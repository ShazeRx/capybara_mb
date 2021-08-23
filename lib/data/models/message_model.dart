import 'package:capybara_app/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel(String? timestamp, {message, username})
      : super(timestamp, username: username, message: message);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(json['timestamp'],
        message: json['message'], username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp": this.timestamp,
      "username": this.username,
      "message": this.message
    };
  }
}
