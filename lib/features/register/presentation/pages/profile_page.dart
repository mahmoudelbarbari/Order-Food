import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/register/presentation/cubit/profile_cubit.dart';
import 'package:order/features/register/presentation/cubit/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RegisterAccountEntity loggedUser = RegisterAccountEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit()..getUserInfo(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProfileInfoSuccessState) {
              return Text(loggedUser.name!);
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
