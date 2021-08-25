import 'package:equatable/equatable.dart';

class RefreshModel extends Equatable {
  final String access;

  RefreshModel({required this.access});

  factory RefreshModel.fromJson(Map<String, dynamic> json) {
    return RefreshModel(
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': this.access,
    };
  }

  @override
  List<Object> get props => [this.access];
}
