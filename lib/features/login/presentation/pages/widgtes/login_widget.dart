import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/register/presentation/pages/register_page.dart';

import '../../../../../core/widgets/botton_auth_row_widget.dart';
import '../../../../../core/widgets/common_elevated_button_widget.dart';
import '../../cubit/login_cubit.dart';
import 'login_header_widget.dart';
import 'login_textfield_widget.dart';
import 'login_top_image_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyform,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopImage(),
              // const SizedBox(height: 100),
              const LoginHeaderWidget(),
              const SizedBox(height: 15),
              LoginTextFieldWidget(
                  labelText: "Email",
                  obscureText: false,
                  prefixIcon: const Icon(Icons.email),
                  controllerEmail: controllerEmail),
              const SizedBox(height: 12),
              LoginTextFieldWidget(
                obscureText: passwordVisible,
                controllerEmail: controllerPassword,
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              const SizedBox(height: 12),
              CommonElevatedButton(
                text: "Log in",
                onTap: () {
                  setState(() {
                    if (_keyform.currentState!.validate()) {
                      context.read<LoginCubit>().remoteLogin(
                          controllerEmail.text.trim(),
                          controllerPassword.text,
                          context);
                    }
                  });
                },
              ),
              BottomAuthRowWidget(
                text: "Don't have an account",
                value: "Sign up",
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
