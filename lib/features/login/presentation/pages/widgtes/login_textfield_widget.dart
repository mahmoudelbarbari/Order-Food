import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    Key? key,
    required this.controllerEmail,
    required this.prefixIcon,
    required this.labelText,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController controllerEmail;
  final Widget prefixIcon;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return 'Please fill the form';
        }
      },
      controller: controllerEmail,
    );
  }
}
