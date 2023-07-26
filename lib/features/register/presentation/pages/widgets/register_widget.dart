import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/login/presentation/pages/login_page.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/register/presentation/cubit/register_cubit.dart';

import '../../../../../core/util/botton_auth_row_widget.dart';
import 'email_text_field_widget.dart';
import 'mobile_text_field_widget.dart';
import 'password_text_field_widget.dart';
import 'register_text_field_widget.dart';

class RegisterWidget extends StatefulWidget {
  final RegisterAccountEntity registerAccountEntity;
  const RegisterWidget({super.key, required this.registerAccountEntity});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late TextEditingController controllerUsername;
  late TextEditingController controllerPassword;
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerGender;
  late TextEditingController controllerPhone;
  late GlobalKey<FormState> _keyform;

  @override
  void initState() {
    super.initState();
    controllerUsername = TextEditingController();
    controllerPassword = TextEditingController();
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerGender = TextEditingController();
    controllerPhone = TextEditingController();
    _keyform = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    controllerName.dispose();
    controllerEmail.dispose();
    controllerGender.dispose();
    controllerPhone.dispose();
    super.dispose();
  }

  String? selectedValue;
  List<String> items = [
    'Female',
    'Male',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyform,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RegisterTextFieldWidget(
                    controller: controllerUsername, labelText: 'Username'),
                const SizedBox(height: 12),
                RegisterTextFieldWidget(
                    controller: controllerName, labelText: 'Name'),
                const SizedBox(height: 12),
                EmailTextFieldWidget(controllerEmail: controllerEmail),
                const SizedBox(height: 12),
                PasswordTextFieldWidget(controllerPassword: controllerPassword),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  hint: const Text(
                    'Gender',
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      controllerGender.text = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                MobileTextFieldWidget(controllerPhone: controllerPhone),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(327, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    setState(() {
                      if (_keyform.currentState!.validate()) {
                        context.read<RegisterCubit>().registerAccountFromRemote(
                            registerAccountEntity: RegisterAccountEntity(
                              gender: controllerGender.text.trim(),
                              name: controllerName.text,
                              phoneNumber: controllerPhone.text,
                              username: controllerUsername.text,
                            ),
                            email: controllerEmail.text.trim(),
                            password: controllerPassword.text);
                      }
                    });
                  },
                  child: const Text('Sign up'),
                ),
                BottomAuthRowWidget(
                    text: "Already have an account? ",
                    value: "Login Now",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
