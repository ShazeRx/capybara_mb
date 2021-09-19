import 'package:capybara_app/domain/entities/auth/token.dart';

class TokenModel extends Token {
  TokenModel({
    required String refresh,
    required String access,
  }) : super(refresh: refresh, access: access);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      refresh: json['token']['refresh'],
      access: json['token']['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': {
        'refresh': this.refresh,
        'access': this.access,
      }
    };
  }
}
