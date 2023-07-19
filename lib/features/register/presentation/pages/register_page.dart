import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/login/presentation/pages/login_page.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/register/presentation/cubit/register_cubit.dart';
import 'package:order/features/register/presentation/cubit/register_state.dart';
import 'package:order/features/register/presentation/pages/register_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterAccountEntity registerAccountEntity = RegisterAccountEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Register Page"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is CreateUserSuccessfully) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
              registerAccountEntity = state.registerAccountEntity;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.registerAccountEntity.message ??
                      "You created an account successfully")));
            }
            if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return RegisterWidget(registerAccountEntity: registerAccountEntity);
          },
        ),
      ),
    );
  }

  // Widget _buildBody() {
  //   return BlocProvider<RegisterCubit>(
  //     create: (_) => RegisterCubit(),
  //     child: Padding(
  //       padding: const EdgeInsets.all(10),
  //       child: BlocConsumer<RegisterCubit, RegisterState>(
  //         listener: (context, state) {
  //           if (state is CreateUserSuccessfully) {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 backgroundColor: Colors.green,
  //                 content: Text(state.registerAccountEntity.message ??
  //                     "You created an account successfully")));
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => const LoginPage(),
  //                 ));
  //             registerAccountEntity = state.registerAccountEntity;
  //           }
  //           if (state is RegisterErrorState) {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 backgroundColor: Colors.red,
  //                 content: Text(state.errorMessage)));
  //           }
  //         },
  //         builder: (context, state) {
  //           return RegisterWidget(registerAccountEntity: registerAccountEntity);
  //         },
  //       ),
  //     ),
  //   );
  // }
}
