import 'package:dio/dio.dart';

import '../common/app_constant.dart';
import '../model/auth_token.dart';
import '../model/users_me.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstant.baseUrl,
      responseType: ResponseType.plain,
      validateStatus: (int? code) {
        return true;
      },
    ),
  );

  static Future<AuthToken> login({
    required String username,
    required String password,
  }) async {
    Response<String> response = await _dio.post<String>(
      '/jwt-auth/v1/token',
      data: <String, String>{
        'username': username,
        'password': password,
      },
    );
    return AuthToken.fromJson(response.data ?? '{}');
  }

  static Future<UsersMe> getMe(String token) async {
    assert(token.isNotEmpty);
    Response<String> response = await _dio.get(
      '/wp/v2/users/me',
      options: Options(
        headers: <String, String>{
          'authorization': 'Bearer $token',
        },
      ),
    );
    return UsersMe.fromJson(response.data ?? '{}');
  }
}
