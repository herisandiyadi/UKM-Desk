import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/home/banner_response.dart';
import 'package:enforcea/model/response/home/video_response.dart';
import 'package:enforcea/repository/home/banner_repository.dart';
import 'package:enforcea/model/response/home/mont_left_response.dart';
import 'package:enforcea/model/response/home/renewal_response.dart';
import 'package:enforcea/model/response/home/content_response.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BannerRepository _bannerRepository;

  HomeCubit(this._bannerRepository) : super(HomeInitial());

  Future<void> getHomePage() async {
    emit(new HomeLoading());
    final renewalPack = await _bannerRepository.getRenewalPack();
    try {
      final taxData = await _bannerRepository.getBannerList(1);
      final articleList = await _bannerRepository.getArticleList(1);
      final newsList = await _bannerRepository.getNewsList(1);
      final videoList = await _bannerRepository.getVideoList();
      final monthLeft = await _bannerRepository.getMonthLeft();
      emit(new HomeLoaded(
          taxData, articleList, newsList, videoList, monthLeft, renewalPack));
    } catch (e) {
      emit(new HomeError(e.toString()));
    }
  }
}
