import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String name;
  final List<User> users;

  Channel({required this.name, required this.users});

  @override
  List<Object?> get props => [this.name, this.users];
}
