import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/api_headers.dart';
import '../../../core/network/http_error_handler.dart';
import '../../../data/models/user_model.dart';
import 'user_repository.dart';

class UserRemoteDataSourceImpl implements UserRepository {
  final http.Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel?> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(ApiConstants.login),
      headers: ApiHeaders.json,
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
  }

  @override
  Future<UserModel> fetchUserProfile(String token) async {
    final response = await client.get(
      Uri.parse('https://your-api.com/api/profile'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      throw ServerException(
        message: 'Failed to fetch profile',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<UserModel> getProfile(String token) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final response = await client.post(
      Uri.parse(ApiConstants.register),
      headers: ApiHeaders.json,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
  }
}
