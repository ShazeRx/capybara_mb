import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String name;

  Channel({required this.name});

  @override
  List<Object?> get props => [this.name];
}
