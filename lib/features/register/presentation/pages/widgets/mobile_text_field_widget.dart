import 'package:flutter/material.dart';

class MobileTextFieldWidget extends StatelessWidget {
  const MobileTextFieldWidget({
    Key? key,
    required this.controllerPhone,
  }) : super(key: key);

  final TextEditingController controllerPhone;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerPhone,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone Number',
        prefixIcon: Icon(Icons.smartphone_sharp),
      ),
      validator: (value, {int i = 1}) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Phone number.';
        }
        if (!RegExp(
                r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
            .hasMatch(value)) {
          return 'Please enter an valid phone number';
        }
        return null;
      },
    );
  }
}
