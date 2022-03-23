import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/model/response/consulting_response.dart';

class ConsultingRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ConsultingResponse> fetchAdvisUmum(token) async {
    final response = await _helper.get("advis_umum?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> fetchReviuPajak(token) async {
    final response = await _helper.get("reviu_pajak?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> fetchSTPTahunan(token) async {
    final response = await _helper.get("spt_tahunan?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> fetchPengPajak(token) async {
    final response = await _helper.get("pengembalian_pajak?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> fetchKebPajak(token) async {
    final response = await _helper.get("keberatan_pajak?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }

  Future<ConsultingResponse> fetchManagement(token) async {
    final response = await _helper.get("manajement?bahasa=id", token);
    return ConsultingResponse.fromJson(response);
  }
}
