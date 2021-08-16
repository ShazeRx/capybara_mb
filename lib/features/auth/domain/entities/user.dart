import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;

  User({
    required this.username,
    required this.email,
  });

  @override
  List<Object> get props => [this.username, this.email];
}
