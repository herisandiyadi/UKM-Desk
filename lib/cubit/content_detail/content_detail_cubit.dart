import 'package:bloc/bloc.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/content_datail_repository.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/model/response/content_detail_response.dart';

part 'content_detail_state.dart';

class ContentCubit extends Cubit<ContentDetailState> {
  final ContentDetailRepository _contentRepository;

  ContentCubit(this._contentRepository) : super(ContentInitial());

  Future<void> FlashContent(int contentID) async {
    try {
      emit(new ContentLoading());
      final contentData =
          await _contentRepository.getContentDetailNews(contentID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }

  Future<void> ArticleContent(int contentID) async {
    try {
      emit(new ContentLoading());
      final contentData =
          await _contentRepository.getContentDetailInsight(contentID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }

  Future<void> NewsContent(int contentID) async {
    try {
      emit(new ContentLoading());
      final contentData =
          await _contentRepository.getContentDetailTaxNews(contentID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }
}
