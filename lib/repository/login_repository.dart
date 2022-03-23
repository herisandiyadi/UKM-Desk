import 'dart:convert';
import 'package:enforcea/model/request/login_request.dart';
import 'package:enforcea/model/response/login_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:http/http.dart' as http;
import 'package:enforcea/constants.dart';

import 'network_exception.dart';

abstract class ILoginRepository {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginRepository implements ILoginRepository {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final body = jsonEncode(<String, String>{
      'email': request.email,
      'password': request.password,
      'device': 'ios'
    });
    final url = BASE_URL + "login";
    print("=>" + url + ":" + body);
    final response = await http.post(
      url,
      body: body,
    );
    print("=> " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      print("json Decode:" + parsed["api_token"]);
      CacheUtil.putString(CACHE_TOKEN, parsed["api_token"]);
      CacheUtil.putInt(CACHE_ID, parsed["data"]["id"]);
      CacheUtil.putString(CACHE_NAME, parsed["data"]["name"]);
      CacheUtil.putString(CACHE_EMAIL, parsed["data"]["email"]);
      CacheUtil.putBoolean(CACHE_IS_LOGIN, true);
      final login = LoginResponse();
      return login;
    }

    throw NetworkException(parsed['message']);
  }
}
