import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String refresh;
  final String access;

  Token({
    required this.refresh,
    required this.access,
  });

  @override
  List<Object> get props => [this.refresh, this.access];
}
