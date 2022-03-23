import 'package:bloc/bloc.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/consulting_repository.dart';
import 'package:enforcea/model/response/consulting_response.dart';
import 'package:meta/meta.dart';

part 'tax_servoces_state.dart';

class TaxServiceCubit extends Cubit<TaxServicesState> {
  final ConsultingRepository _taxServicesRepository;

  TaxServiceCubit(this._taxServicesRepository) : super(TaxServicesInitial());

  Future<void> LoadTaxServices() async {
    try {
      emit(new TaxServicesLoading());
      final taxServicesAdvisUmum =
          await _taxServicesRepository.fetchAdvisUmum("");
      final taxServicesKebPajak =
          await _taxServicesRepository.fetchKebPajak("");
      final taxServicesManagement =
          await _taxServicesRepository.fetchManagement("");
      final taxServicesPengPajak =
          await _taxServicesRepository.fetchPengPajak("");
      final taxServicesReviuPajak =
          await _taxServicesRepository.fetchReviuPajak("");
      final taxServicesSPTTahunan =
          await _taxServicesRepository.fetchSTPTahunan("");
      emit(new TaxServicesLoaded(
          taxServicesAdvisUmum,
          taxServicesKebPajak,
          taxServicesManagement,
          taxServicesPengPajak,
          taxServicesReviuPajak,
          taxServicesSPTTahunan));
    } on NetworkException catch (e) {
      emit(TaxServicesError(e.toString()));
    }
  }
}
