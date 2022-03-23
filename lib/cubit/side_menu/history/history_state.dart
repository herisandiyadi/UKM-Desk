part of 'history_cubit.dart';

@immutable
abstract class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final HistoryResponse historyData;

  const HistoryLoaded(this.historyData);
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);
}
