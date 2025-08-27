class   ApiResponse<T> {
  final bool success;
  final T? data;
  final dynamic errors;

  ApiResponse({required this.success, this.data, this.errors});

  /// Factory using since call API is successful
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      data: json['success'] == true && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
      errors: json['errors'],
    );
  }

  /// Factory using since call API is unsuccessful(failure)
  factory ApiResponse.failure(dynamic error) {
     return ApiResponse<T>(
      success: false,
      data: null,
      errors: error,
    );
  }
}
