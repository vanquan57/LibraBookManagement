Map<String, dynamic> buildErrorResponse(
  String errorMessage, {
  String errorCode = 'UNKNOWN',
}) {
  return {
    'success': false,
    'data': null,
    'errors': {'error_code': errorCode, 'error_message': errorMessage},
  };
}
