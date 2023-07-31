import 'package:order/features/register/data/models/register_account_model.dart';

import '../../../login/domain/entities/account_entites.dart';
import '../entities/register_entities.dart';

abstract class RegisterAccountRepository {
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity);

  Future<LoginBaseResponse> getUserInfo(
      RegisterAccountModel registerAccountModel);
}
