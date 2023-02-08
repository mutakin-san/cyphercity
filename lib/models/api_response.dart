import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final int code;
  final String status;
  final Object? response;
  final String? message;

  const ApiResponse(
      {required this.code, required this.status, this.response, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> mapJson) {
    return ApiResponse(
        code: mapJson['code'],
        status: mapJson['status'],
        response: mapJson['response'],
        message: mapJson['msg']);
  }

  @override
  List<Object?> get props => [code, status, response, message];
}
