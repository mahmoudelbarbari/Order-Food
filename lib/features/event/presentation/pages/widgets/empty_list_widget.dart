import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:order/core/theme_app.dart';

import '../../../../../gen/assets.gen.dart';
import '../../cubit/ticket_cubit.dart';

class TicketEmptyListWidget extends StatefulWidget {
  const TicketEmptyListWidget({super.key});

  @override
  State<TicketEmptyListWidget> createState() => _TicketEmptyListWidgetState();
}

class _TicketEmptyListWidgetState extends State<TicketEmptyListWidget> {
  Future<void> _refresh() async {
    setState(() {
      context.read<TicketCubit>().getAllTickets();
    });
    return await Future.delayed(
      const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(children: [
        Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset(Assets.images.emptyList),
            const SizedBox(height: 12),
            Text(
              "There is no open session at the moment..!  :) ",
              style: TextStyle(color: appTheme.primaryColor),
            )
          ]),
        ),
      ]),
    );
  }
}
