import 'package:order/features/login/domain/entities/account_entites.dart';
import 'package:order/features/login/domain/repositories/account_repository.dart';

class LoginUsecase {
  final AccountRepository _accountRepository;

  LoginUsecase(this._accountRepository);

  Future<LoginBaseResponse> call(String username, String password) async {
    // return await _accountRepository.login(username, password);
    throw UnimplementedError();
  }
}
