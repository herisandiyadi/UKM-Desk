import 'dart:convert';
import 'package:enforcea/util/cache_util.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'network_exception.dart';
import 'package:enforcea/api_helper/apiBaseHelper.dart';

abstract class IProfileRepository {
  Future<String> profile();

  Future<bool> updatePassword(String email);
}

class ProfileRepository implements IProfileRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  @override
  Future<String> profile() async {
    final url = BASE_URL + "profile_user";
    final Map<String, String> header = {
      'Authorization': 'bearer ' + await CacheUtil.getString(CACHE_TOKEN)
    };

    print("GET ==> " + url + header.toString());

    final response = await http.get(url, headers: header);
    print("GET <== " +
        response.statusCode.toString() +
        " " +
        url +
        ":" +
        response.body);
    final Map<String, dynamic> parsed = json.decode(response.body);
    if (response.statusCode == 200) {
      print("json Decode:" + parsed["success"].toString());
      final bool isSuccess = parsed["success"];
      if (!isSuccess) {
        throw NetworkException(parsed["message"]);
      }
      return response.body;
    }
    throw NetworkException(parsed["message"]);
  }

  @override
  Future<bool> updatePassword(String email) async {
    final body = jsonEncode(<String, dynamic>{"email": email});

    final response = await _helper.post("change_password", "", body);
    print(response);
    return response["success"];
  }
}
