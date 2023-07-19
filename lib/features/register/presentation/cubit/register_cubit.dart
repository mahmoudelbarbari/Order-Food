import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/register/domain/usecase/remote_register_usecase.dart';
import 'package:order/features/register/presentation/cubit/register_state.dart';
import 'package:order/injection_container.dart';
import '../../domain/usecase/register_usecase.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late RegisterUsecase registerUsecase;

  RegisterCubit() : super(RegisterStateInt());

  Future<void> registerAccountFromRemote(
      {required String email,
      required String password,
      required RegisterAccountEntity registerAccountEntity}) async {
    emit(RegisterLoadingState());
    final remoteRegisterUsecase = RemoteRegisterUsecase(sl());

    try {
      await remoteRegisterUsecase(email, password, registerAccountEntity);
      emit(CreateUserSuccessfully(
        registerAccountEntity: registerAccountEntity,
      ));
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(
        errorMessage: e.message.toString(),
      ));
    }
  }

  Future<void> registerAccount(RegisterAccountEntity registerAccount) async {
    try {
      emit(RegisterLoadingState());

      final registered = await registerUsecase.call(registerAccount);
      if (registered.status) {
        emit(RegisteredState(registered));
      } else {
        emit(RegisterErrorState(errorMessage: registered.message));
      }
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}
