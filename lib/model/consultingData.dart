import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:enforcea/repository/consulting_repository.dart';
import 'package:enforcea/model/response/api_response.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/constants.dart';

class ConsultingData {
  static const int ADVIS_UMUM = 1;
  static const int REVIU_PAJAK = 2;
  static const int SPT_TAHUNAN = 3;
  static const int PENGENBALIAN_PAJAK = 4;
  static const int KEBERATAN_PAJAK = 5;
  static const int MANAJEMEN = 6;
  static const int FAQ = 7;

  // ConsultingData({this.title = "", this.value = "", this.type, this.image = ""});
  List<ConsultingModel> listConsult = new List();
  ConsultingRepository _consultingRepository;
  StreamController _consultingListController;
  StreamSink<ApiResponse<List<ConsultingModel>>> get consulListSink =>
      _consultingListController.sink;

  Stream<ApiResponse<List<ConsultingModel>>> get consulListStream =>
      _consultingListController.stream;
  var token;

  ConsultingData() {
    _consultingListController =
        StreamController<ApiResponse<List<ConsultingModel>>>();
    _consultingRepository = ConsultingRepository();
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
      ConsultingResponse consulting =
          await _consultingRepository.fetchAdvisUmum(token);

      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: ADVIS_UMUM,
      ));

      consulting = await _consultingRepository.fetchReviuPajak(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: REVIU_PAJAK,
      ));

      consulting = await _consultingRepository.fetchSTPTahunan(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: SPT_TAHUNAN,
      ));

      consulting = await _consultingRepository.fetchPengPajak(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: PENGENBALIAN_PAJAK,
      ));

      consulting = await _consultingRepository.fetchKebPajak(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: KEBERATAN_PAJAK,
      ));

      consulting = await _consultingRepository.fetchManagement(token);
      listConsult.add(ConsultingModel(
        isi: consulting.data.isi,
        image_1: consulting.data.image_1,
        image_2: consulting.data.image_2,
        type: MANAJEMEN,
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

class ConsultingModel {
  int type;
  String isi;
  String image_1;
  String image_2;
  ConsultingModel({this.type, this.isi, this.image_1, this.image_2});
}
