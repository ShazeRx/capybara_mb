import 'package:equatable/equatable.dart';

class RefreshRequest extends Equatable {
  final String refresh;

  RefreshRequest({required this.refresh});

  Map<String, dynamic> toJson() {
    return {'refresh': this.refresh};
  }

  factory RefreshRequest.fromParams(params) {
    return RefreshRequest(
      refresh: params.refresh,
    );
  }

  @override
  List<Object> get props => [this.refresh];
}
