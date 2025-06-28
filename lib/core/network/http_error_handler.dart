import 'package:learncosmetic/core/errors/exceptions.dart';

class HttpErrorHandler {
  static void handle(int statusCode, String responseBody) {
    switch (statusCode) {
      case 200:
      case 201:
      case 204:
        // Do nothing (success)
        break;

      case 400:
        throw ServerException(message: 'Bad Request: Check your input data.');
      case 401:
        throw ServerException(
          message: 'Unauthorized: Please check your credentials.',
        );
      case 403:
        throw ServerException(message: 'Forbidden: You don\'t have access.');
      case 404:
        throw ServerException(
          message: 'Not Found: The resource does not exist.',
        );
      case 408:
        throw ServerException(message: 'Request Timeout: Please try again.');
      case 422:
        throw ServerException(
          message: 'Unprocessable Entity: Invalid data format.',
        );
      case 500:
        throw ServerException(
          message: 'Internal Server Error: Something went wrong.',
        );
      case 502:
        throw ServerException(message: 'Bad Gateway: Something went wrong.');
      case 503:
        throw ServerException(
          message: 'Service Unavailable: Something went wrong.',
        );
      case 504:
        throw ServerException(
          message: 'Gateway Timeout: Something went wrong.',
        );

      default:
        throw ServerException(message: 'Something went wrong.');
    }
  }
}
