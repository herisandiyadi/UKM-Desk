import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:enforcea/repository/template_repository.dart';
import 'package:enforcea/model/response/api_response.dart';
import 'package:enforcea/model/response/template_response.dart';
import 'package:enforcea/util/cache_util.dart';
import 'package:enforcea/constants.dart';

class TemplateData {
  TemplateRepository _templateRepository;
  StreamController _templateListController;
  StreamSink<ApiResponse<TemplateResponse>> get templateSink =>
      _templateListController.sink;

  Stream<ApiResponse<TemplateResponse>> get templateStream =>
      _templateListController.stream;
  var token;

  TemplateData() {
    _templateListController = StreamController<ApiResponse<TemplateResponse>>();
    _templateRepository = TemplateRepository();

    CacheUtil.getString(CACHE_TOKEN).then((value) {
      token = value;
      fetchTemplate();
    });
  }

  fetchTemplate() async {
    templateSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      // TemplateResponse templating =
      //     await _templateRepository.fetchTemplate(token);
      // templateSink.add(ApiResponse.completed(templating));
    } catch (e) {
      templateSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _templateListController?.close();
  }
}
