import '../../core/enums/status.dart';

class ApiResponse<T> {
  T? data;
  Status? status;
  String? message;

  ApiResponse(this.data, this.message, this.status);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.success(this.data) : status = Status.complete;
  
  ApiResponse.error(this.message) : status = Status.error;
}