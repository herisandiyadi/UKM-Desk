part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class DownloadLoading extends HomeState {
  const DownloadLoading();
}

class HomeLoaded extends HomeState {
  final ContentResponse bannerData;
  final ContentResponse articleData;
  final ContentResponse newsData;
  final VideoResponse videoData;
  final MonthLeftResponse monthLeft;
  final RenewalResponse renewalPack;
  const HomeLoaded(this.bannerData, this.articleData, this.newsData,
      this.videoData, this.monthLeft, this.renewalPack);
}

class DownloadLoaded extends HomeState {
  final String downloadData;

  const DownloadLoaded(this.downloadData);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
