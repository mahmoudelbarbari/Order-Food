import 'package:flutter/material.dart';

import '../../../../restaurant/presentation/pages/get_menu_pages/get_menu_page.dart';

class BottomContainerCartWidget extends StatelessWidget {
  const BottomContainerCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 40,
            width: 120,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AllMenuPage(),
              )),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 207, 78, 27))),
              child: const Text("Add Item"),
            ),
          ),
          const SizedBox(width: 30),
          SizedBox(
            height: 40,
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text("Check out"),
            ),
          ),
        ],
      ),
    );
  }
}
