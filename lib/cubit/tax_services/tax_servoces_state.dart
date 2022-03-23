part of 'tax_services_cubit.dart';

@immutable
abstract class TaxServicesState {
  const TaxServicesState();
}

class TaxServicesInitial extends TaxServicesState {
  const TaxServicesInitial();
}

class UpdateLoading extends TaxServicesState {
  const UpdateLoading();
}

class UpdateLoaded extends TaxServicesState {
  final bool isSuccess;

  const UpdateLoaded(this.isSuccess);
}

class TaxServicesLoading extends TaxServicesState {
  const TaxServicesLoading();
}

class TaxServicesLoaded extends TaxServicesState {
  final ConsultingResponse advisUmum;
  final ConsultingResponse kebPajak;
  final ConsultingResponse management;
  final ConsultingResponse pengPajak;
  final ConsultingResponse reviuPajak;
  final ConsultingResponse sptTahunan;

  const TaxServicesLoaded(this.advisUmum, this.kebPajak, this.management,
      this.pengPajak, this.reviuPajak, this.sptTahunan);
}

class TaxServicesError extends TaxServicesState {
  final String message;

  const TaxServicesError(this.message);
}
