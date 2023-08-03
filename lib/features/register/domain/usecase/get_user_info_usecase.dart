import '../entities/register_entities.dart';
import '../reposisatory/register_reprisatory.dart';

class GetUserInfoUsecase {
  final RegisterAccountRepository _registerAccountRepository;
  GetUserInfoUsecase(this._registerAccountRepository);

  Future<RegisterAccountEntity> call() async {
    return await _registerAccountRepository.getUserInfo();
  }
}
