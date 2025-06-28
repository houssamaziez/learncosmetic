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
        throw ServerException(
          message: 'Bad Request: Check your input data.',
          statusCode: statusCode,
        );
      case 401:
        throw ServerException(
          message: 'Unauthorized: Please check your credentials.',
          statusCode: statusCode,
        );
      case 403:
        throw ServerException(
          message: 'Forbidden: You don\'t have access.',
          statusCode: statusCode,
        );
      case 404:
        throw ServerException(
          message: 'Not Found: The resource does not exist.',
          statusCode: statusCode,
        );
      case 408:
        throw ServerException(
          message: 'Request Timeout: Please try again.',
          statusCode: statusCode,
        );
      case 422:
        throw ServerException(
          message: 'Unprocessable Entity: Invalid data format.',
          statusCode: statusCode,
        );
      case 500:
        throw ServerException(
          message: 'Internal Server Error: Something went wrong.',
          statusCode: statusCode,
        );
      case 502:
        throw ServerException(
          message: 'Bad Gateway: Something went wrong.',
          statusCode: statusCode,
        );
      case 503:
        throw ServerException(
          message: 'Service Unavailable: Something went wrong.',
          statusCode: statusCode,
        );
      case 504:
        throw ServerException(
          message: 'Gateway Timeout: Something went wrong.',
          statusCode: statusCode,
        );

      default:
        throw ServerException(
          message: 'Something went wrong.',
          statusCode: statusCode,
        );
    }
  }
}
