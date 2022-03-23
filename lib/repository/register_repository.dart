import 'dart:convert';

import 'package:enforcea/model/request/register_request.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'network_exception.dart';

abstract class IRegisterRepository {
  Future<bool> register(RegisterRequest request);
}

class RegisterRepository implements IRegisterRepository {
  @override
  Future<bool> register(RegisterRequest request) async {
    final url = BASE_URL + "registrasi";
    print("POST ==> " + url + ":" + jsonEncode(request));
    final response = await http.post(url, body: jsonEncode(request));
    print("POST <== " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      print("json Decode:" + parsed["success"].toString());
      final bool isSuccess = parsed["success"];
      if(!isSuccess){
        throw NetworkException(parsed["message"]);
      }
      return isSuccess;
    }
    throw NetworkException(parsed["message"]);
  }
}
