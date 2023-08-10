import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Login',
          style: TextStyle(
              fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              _smallParagraph(context,
                  "Chat with your friends and save your details for a faster"),
              const SizedBox(height: 4),
              _smallParagraph(context, "checkout experince."),
            ],
          ),
        ),
      ],
    );
  }

  Text _smallParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color!),
    );
  }
}
