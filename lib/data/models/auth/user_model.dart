import 'package:capybara_app/domain/entities/auth/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String username,
    required String email,
  }) : super(
          id: id,
          username: username,
          email: email,
        );

  factory UserModel.fromUserEntity(User user) {
    return UserModel(id: user.id, username: user.username, email: user.email);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      username: json['user']['username'],
      email: json['user']['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': this.id,
        'username': this.username,
        'email': this.email,
      }
    };
  }

  static List<UserModel> fromJsonToList(List<dynamic> userListJson) {
    return userListJson.map((e) => UserModel.fromJson(e)).toList();
  }
}
