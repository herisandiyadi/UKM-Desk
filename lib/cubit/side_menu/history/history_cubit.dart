import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/history_response.dart';
import 'package:enforcea/repository/history_repository.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _repository;
  HistoryCubit(this._repository) : super(HistoryInitial());

  Future<void> getHistory() async{
    try {
      emit(new HistoryLoading());
      final historyData = await _repository.getHistory();
      emit(new HistoryLoaded(historyData));
    } on  NetworkException catch (e){
      emit(HistoryError(e.toString()));
    }
  }
}
