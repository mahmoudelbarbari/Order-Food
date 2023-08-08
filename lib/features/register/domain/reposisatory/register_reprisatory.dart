import '../entities/register_entities.dart';

abstract class RegisterAccountRepository {
  Future<RegisterAccountEntity> remoteRegisterUser(String email,
      String password, RegisterAccountEntity registerAccountEntity);

  Future<List<RegisterAccountEntity>> getUserInfo();
}
