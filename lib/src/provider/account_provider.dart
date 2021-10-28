import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_constant.dart';
import '../model/auth_token.dart';
import '../network/api_client.dart';

class AccountProvider with ChangeNotifier {
  String? _token;
  late final SharedPreferences _preferences;

  String? get token => _token;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences.getString(AppConstant.keyToken);
  }

  Future<AuthToken> login({
    required String username,
    required String password,
  }) async {
    AuthToken auth = await ApiClient.login(
      username: username,
      password: password,
    );
    _token = auth.token;
    if (auth.token != null) {
      await _preferences.setString(
        AppConstant.keyToken,
        auth.token!,
      );
    }
    notifyListeners();
    return auth;
  }

  Future<void> logout() async {
    _token = null;
    await _preferences.remove(AppConstant.keyToken);
    notifyListeners();
  }
}
