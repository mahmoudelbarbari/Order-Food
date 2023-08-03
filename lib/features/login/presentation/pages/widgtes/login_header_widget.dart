import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Log in or create an account',
          style: TextStyle(fontSize: 25, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text("Chat with your friends and save your details for a faster"),
        SizedBox(height: 4),
        Text("checkout experince."),
      ],
    );
  }
}
