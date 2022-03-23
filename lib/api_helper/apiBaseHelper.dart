import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:enforcea/api_helper/appException.dart';
import 'dart:convert';
import 'package:enforcea/constants.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url, String token) async {
    var responseJson;
    // var token = "620ff31bf8d4749287790b623e961ae079edf865";
    // CacheUtil.getString(CACHE_TOKEN).then((value) => token = 'bearer ' + value);
    try {
      final response = await http.get(BASE_URL + url, headers: {
        'Authorization': "bearer " + token,
        // 'Cookie':
        //     'XSRF-TOKEN=eyJpdiI6IklSSW5USmtrQ21IRkdHQmtYYnQ4MEE9PSIsInZhbHVlIjoiMWhjYmdFSk1tU0pab1dMTjVcL25CeUk0dEYrck1VaVdMUlByQ1YwdE0rQUYzVjVmNThEOUNCMnJ6Y2x4QjRyOTgiLCJtYWMiOiI0MzNmOTc2Y2RjYTQxMjBlZDAyNWMwMGY2MzhjM2MyMjE1NTFhZTgxMjJhZTg5YzliNmRmNGI4NjMxZDRkNzc3In0%3D; laravel_session=eyJpdiI6IjEweStzWCtXNlhSZ1Bxc2wwc3FMTHc9PSIsInZhbHVlIjoiMFQ1ZEV1NDYzVmwrODBRc0pCN1Z0QlFVQWxrMEpCWGErTGtcLytmVXRVbkNDcGhBZWxPSG5wYWhraUhmNGorS1IiLCJtYWMiOiJmNDZjMTUyMDVhNDg3MjYxZjM0Zjg1NTA2M2U3MDFhY2U5NDVhZTc5MjY4Y2VjZjFhNWIzMmU5NmM2OGI2MjJiIn0%3D',
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, String token, String body) async {
    var responseJson;
    // var token = "620ff31bf8d4749287790b623e961ae079edf865";
    // CacheUtil.getString(CACHE_TOKEN).then((value) => token = 'bearer ' + value);
    try {
      final response = await http.post(BASE_URL + url,
          headers: {
            'Authorization': "bearer " + token,
            // 'Cookie':
            //     'XSRF-TOKEN=eyJpdiI6IklSSW5USmtrQ21IRkdHQmtYYnQ4MEE9PSIsInZhbHVlIjoiMWhjYmdFSk1tU0pab1dMTjVcL25CeUk0dEYrck1VaVdMUlByQ1YwdE0rQUYzVjVmNThEOUNCMnJ6Y2x4QjRyOTgiLCJtYWMiOiI0MzNmOTc2Y2RjYTQxMjBlZDAyNWMwMGY2MzhjM2MyMjE1NTFhZTgxMjJhZTg5YzliNmRmNGI4NjMxZDRkNzc3In0%3D; laravel_session=eyJpdiI6IjEweStzWCtXNlhSZ1Bxc2wwc3FMTHc9PSIsInZhbHVlIjoiMFQ1ZEV1NDYzVmwrODBRc0pCN1Z0QlFVQWxrMEpCWGErTGtcLytmVXRVbkNDcGhBZWxPSG5wYWhraUhmNGorS1IiLCJtYWMiOiJmNDZjMTUyMDVhNDg3MjYxZjM0Zjg1NTA2M2U3MDFhY2U5NDVhZTc5MjY4Y2VjZjFhNWIzMmU5NmM2OGI2MjJiIn0%3D',
          },
          body: body);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
