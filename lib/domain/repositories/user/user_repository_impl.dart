import 'dart:convert';
import 'dart:io';
import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learncosmetic/domain/repositories/promotion/promotion_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/api_headers.dart';
import '../../../core/constants/error_notifier.dart';
import '../../../core/network/http_error_handler.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../presentation/controllers/login_controller.dart';
import 'user_repository.dart';

class UserRemoteDataSourceImpl implements UserRepository {
  final http.Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel?> login(String email, String password) async {
    String? imei = await FlutterDeviceImei.instance.getIMEI();

    final response = await client.post(
      Uri.parse(ApiConstants.login),
      headers: ApiHeaders.json,

      body: json.encode({
        'email': email,
        'password': password,
        "device_id": imei,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      LocalStorageService.setString('token', data['token'] ?? '');

      return UserModel.fromJson(data['user']);
    } else {
      final data = json.decode(response.body);

      if (response.statusCode == 403 || response.statusCode == 401) {
        throw ServerException(
          message: data['message'],
          statusCode: response.statusCode,
        );
      }
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
  }

  @override
  Future<UserModel> fetchUserProfile() async {
    final response = await client.get(
      Uri.parse(ApiConstants.getme),
      headers: ApiHeaders.withToken(),
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
  Future<UserModel> getProfile() async {
    String? imei = await FlutterDeviceImei.instance.getIMEI();

    final response = await client.post(
      Uri.parse(ApiConstants.getme),
      headers: ApiHeaders.withToken(),
      body: json.encode({"device_id": imei}),
    );
    if (response.statusCode == 403 || response.statusCode == 401) {
      throw ServerException(
        message: json.decode(response.body)['message'],
        statusCode: response.statusCode,
      );
    }
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
      ErrorNotifier.showSuccess(data['message']);
      return UserModel.fromJson(data['user']);
    } else {
      HttpErrorHandler.handle(response.statusCode, response.body);
    }
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
    String? address,
    File? imageuser,
  }) async {
    try {
      final uri = Uri.parse(
        ApiConstants.updateProfile +
            Get.find<AuthController>().user!.id.toString(),
      );

      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LocalStorageService.getString('token')}',
      });

      if (name != null) request.fields['name'] = name;
      if (email != null) request.fields['email'] = email;
      if (password != null) request.fields['password'] = password;
      if (confirmPassword != null) {
        request.fields['password_confirmation'] = confirmPassword;
      }
      if (phone != null) request.fields['phone'] = phone;
      if (address != null) request.fields['address'] = address;

      if (imageuser != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imageuser', imageuser.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // ErrorNotifier.showSuccess('تم تحديث الملف الشخصي بنجاح');
      } else {
        HttpErrorHandler.handle(response.statusCode, response.body);
      }
    } catch (e) {
      ErrorNotifier.show('حدث خطأ أثناء التحديث: ${e.toString()}');
    }
  }
}
