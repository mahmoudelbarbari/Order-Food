import 'package:flutter/material.dart';

class BottomAuthRowWidget extends StatelessWidget {
  const BottomAuthRowWidget({
    Key? key,
    required this.text,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        TextButton(
          onPressed: onTap,
          child: Text(value),
        )
      ],
    );
  }
}
