import 'package:order/features/event/domain/entities/event_entities.dart';

import '../entities/register_entities.dart';
import '../reposisatory/register_reprisatory.dart';

class RegisterUsecase {
  final RegisterAccountRepository _registerAccountRepository;

  RegisterUsecase(this._registerAccountRepository);

  Future<BaseResponse> call(RegisterAccountEntity registerAccount) async {
    // return await _registerAccountRepository.registerAccount(registerAccount);
    throw UnimplementedError();
  }
}
