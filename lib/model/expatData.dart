import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:enforcea/repository/expat_repository.dart';
import 'package:enforcea/model/response/api_response.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:enforcea/model/consultingData.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/constants.dart';

class ExpatData {
  static const int FDI_TAX = 1;
  static const int BRANCH = 2;
  static const int EXPATRIATES_TAX = 3;
  static const int DIGITAL_TAX = 4;
  static const int REPRESENTATIVE = 5;

  // ExpatData({this.title = "", this.value = "", this.type, this.image = ""});
  List<ConsultingModel> listConsult = new List();
  ExpatRepository _expatRepository;
  StreamController _consultingListController;
  StreamSink<ApiResponse<List<ConsultingModel>>> get consulListSink =>
      _consultingListController.sink;

  Stream<ApiResponse<List<ConsultingModel>>> get consulListStream =>
      _consultingListController.stream;
  var token;

  ExpatData() {
    _consultingListController =
        StreamController<ApiResponse<List<ConsultingModel>>>();
    _expatRepository = ExpatRepository();
    // CacheUtil.getString(CACHE_TOKEN).then((value) {
    //   token = value;
    //   fetchConsulting();
    // });
    token = "";
    fetchConsulting();
  }

  fetchConsulting() async {
    consulListSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      ConsultingResponse consulting = await _expatRepository.fdiTax(token);

      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: FDI_TAX,
      ));

      consulting = await _expatRepository.branch(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: BRANCH,
      ));

      consulting = await _expatRepository.expatriatesTax(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: EXPATRIATES_TAX,
      ));

      consulting = await _expatRepository.digitalTax(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: DIGITAL_TAX,
      ));

      consulting = await _expatRepository.representative(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: REPRESENTATIVE,
      ));

      consulListSink.add(ApiResponse.completed(listConsult));
    } catch (e) {
      consulListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _consultingListController?.close();
  }
}
