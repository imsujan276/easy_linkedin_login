/// Exception handler for HTTP response
class HttpResponseException implements Exception {
  HttpResponseException({
    required this.statusCode,
    required this.message,
  });

  final String message;
  final int statusCode;

  @override
  String toString() =>
      'HttpResponseException(message: $message, statusCode: $statusCode)';
}
