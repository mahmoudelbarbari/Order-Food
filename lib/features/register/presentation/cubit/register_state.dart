import 'package:order/features/register/domain/entities/register_entities.dart';

abstract class RegisterState {}

class RegisteredState extends RegisterState {
  RegisteredState(registered);
}

class RegisterErrorState extends RegisterState {
  String errorMessage;
  RegisterErrorState({required this.errorMessage});
}

class RegisterStateInt extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class CreateUserSuccessfully extends RegisterState {
  RegisterAccountEntity registerAccountEntity;
  CreateUserSuccessfully({required this.registerAccountEntity});
}
