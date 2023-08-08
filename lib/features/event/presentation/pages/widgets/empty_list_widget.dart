import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:order/core/theme_app.dart';

import '../../../../../gen/assets.gen.dart';

class TicketEmptyListWidget extends StatelessWidget {
  const TicketEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.emptyList),
          const SizedBox(height: 12),
          Text(
            "There is no open session at the moment..!  :) ",
            style: TextStyle(color: appTheme.primaryColor),
          )
        ],
      ),
    );
  }
}
