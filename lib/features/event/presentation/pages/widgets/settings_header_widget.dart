import 'package:flutter/material.dart';

class SettingsHeaderWidget extends StatelessWidget {
  const SettingsHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 9, color: Color.fromRGBO(179, 192, 195, 0.08)),
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: const Color.fromRGBO(72, 129, 255, 0.06),
              radius: 50,
              child: Image.asset('assets/images/profile.png')),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'osamam.22@gmail.com',
                  maxLines: 1,
                  style: TextStyle(color: Colors.grey),
                ),
                Text('Osama Mamdouh Kamel',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
