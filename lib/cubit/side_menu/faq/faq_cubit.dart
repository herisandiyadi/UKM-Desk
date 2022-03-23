import 'package:bloc/bloc.dart';
import 'package:enforcea/model/response/faq_response.dart';
import 'package:enforcea/repository/faq_repository.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:meta/meta.dart';

part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FAQRepository _faqRepository;

  FaqCubit(this._faqRepository) : super(FaqInitial());

  Future<void> getFaq() async{
    try{
      emit(new FaqLoading());
      final faqData = await _faqRepository.getFAQ();
      emit(new FaqLoaded(faqData));
    } on NetworkException catch (e){
      emit(FaqError(e.toString()));
    }
  }
}
