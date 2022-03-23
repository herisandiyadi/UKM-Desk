import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/consulting_response.dart';

class ExpatRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ConsultingResponse> fdiTax(token) async {
    final response = await _helper.get("fdi_tax?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> branch(token) async {
    final response = await _helper.get("branch?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> expatriatesTax(token) async {
    final response = await _helper.get("expatriates_tax?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> digitalTax(token) async {
    final response = await _helper.get("digital_tax?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> representative(token) async {
    final response = await _helper.get("representative?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }
}
