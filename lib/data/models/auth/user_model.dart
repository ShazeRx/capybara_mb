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
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'username': this.username,
      'email': this.email,
    };
  }
}
