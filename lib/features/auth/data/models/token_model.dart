import 'package:capybara_app/features/auth/domain/entities/token.dart';

class TokenModel extends Token {
  TokenModel({
    required String refresh,
    required String access,
  }) : super(refresh: refresh, access: access);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh': this.refresh,
      'access': this.access,
    };
  }
}
