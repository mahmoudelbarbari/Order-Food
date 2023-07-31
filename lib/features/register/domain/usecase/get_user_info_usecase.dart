import 'package:order/features/login/domain/entities/account_entites.dart';
import 'package:order/features/register/data/models/register_account_model.dart';

import '../reposisatory/register_reprisatory.dart';

class GetUserInfoUsecase {
  final RegisterAccountRepository _registerAccountRepository;
  GetUserInfoUsecase(this._registerAccountRepository);

  Future<LoginBaseResponse> call(
      RegisterAccountModel registerAccountModel) async {
    return await _registerAccountRepository.getUserInfo(registerAccountModel);
  }
}
