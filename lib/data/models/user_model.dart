import 'package:capybara_app/domain/entities/user.dart';

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
