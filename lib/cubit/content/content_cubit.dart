import 'package:bloc/bloc.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/home/banner_repository.dart';
import 'package:meta/meta.dart';
import 'package:enforcea/model/response/home/content_response.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  final BannerRepository _contentRepository;

  ContentCubit(this._contentRepository) : super(ContentInitial());

  Future<void> FlashContent(int pageID) async {
    try {
      emit(new ContentLoading());
      final contentData = await _contentRepository.getBannerList(pageID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }

  Future<void> ArticleContent(int pageID) async {
    try {
      emit(new ContentLoading());
      final contentData = await _contentRepository.getArticleList(pageID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }

  Future<void> NewsContent(int pageID) async {
    try {
      emit(new ContentLoading());
      final contentData = await _contentRepository.getNewsList(pageID);
      emit(new ContentLoaded(contentData));
    } on NetworkException catch (e) {
      emit(ContentError(e.toString()));
    }
  }
}
