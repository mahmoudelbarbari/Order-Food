import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/register/data/models/register_account_model.dart';
import 'package:order/features/register/domain/usecase/get_user_info_usecase.dart';
import 'package:order/features/register/presentation/cubit/profile_state.dart';
import 'package:order/injection_container.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoadingState());

  late GetUserInfoUsecase getUserInfoUsecase;

  Future<void> getUserInfo(RegisterAccountModel registerAccountModel) async {
    emit(ProfileLoadingState());
    getUserInfoUsecase = sl<GetUserInfoUsecase>();

    emit(ProfileInfoSuccessState(registerAccountEntity: registerAccountModel));
  }
}
