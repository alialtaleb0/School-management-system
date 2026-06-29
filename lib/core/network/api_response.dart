class ApiResponse<T> {
  final String? message;
  final T? data;
  final bool success;
  ApiResponse({required this.success, this.data,this.message});
}