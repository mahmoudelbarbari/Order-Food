import '../../domain/entities/register_entities.dart';

abstract class ProfileState {}

class ProfileInfoSuccessState extends ProfileState {
  RegisterAccountEntity registerAccountEntity;
  ProfileInfoSuccessState({required this.registerAccountEntity});
}

class ProfileLoadingState extends ProfileState {}

class ProfileInfoErrorState extends ProfileState {
  String message;
  ProfileInfoErrorState({required this.message});
}
