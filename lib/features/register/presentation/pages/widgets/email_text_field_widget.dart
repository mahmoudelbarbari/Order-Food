import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextFieldWidget extends StatelessWidget {
  const EmailTextFieldWidget({
    Key? key,
    required this.controllerEmail,
  }) : super(key: key);

  final TextEditingController controllerEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return 'Please enter your mail address.';
        }
        // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
        //   return "Please enter a valid email address";
        // }
        // const String email = 'fredrik.eilertsen@gail.com';
        final bool isValid = EmailValidator.validate(value);
        if (!isValid) {
          return "Please enter a valid email address";
        }
        return null;
      },
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        labelText: 'Example@gmail.com',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
