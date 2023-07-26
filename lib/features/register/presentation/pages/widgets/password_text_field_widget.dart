import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.controllerPassword,
  }) : super(key: key);

  final TextEditingController controllerPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.multiline,
      controller: controllerPassword,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Password.';
        }
        if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+').hasMatch(value)) {
          return 'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters';
        }
        return null;
      },
    );
  }
}
