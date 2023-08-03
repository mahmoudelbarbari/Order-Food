import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/drawer_menu.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/features/cart/presentation/pages/cart_page.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/cubit/ticket_state.dart';
import 'package:order/features/event/presentation/pages/widgets/floating_button_home_widget.dart';

import '../pages/widgets/ticket_widget.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

String _greetings() {
  final hour = TimeOfDay.now().hour;

  if (hour <= 12) {
    return 'Good Morning';
  } else if (hour <= 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Badge(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
        title: Text(
          'Welcome, ${_greetings()}',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      drawer: const NavigationDrawerr(),
      body: _buildBody(),
      floatingActionButton: const FloatingButtonHomeWidget(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<TicketCubit, TicketState>(
        listener: (context, state) {
          if (state is TicketErrorState) {
            if (kDebugMode) {
              print(state.errorMessage);
            }
          }
        },
        builder: (context, state) {
          if (state is TicketLoadedState) {
            return TicketWidget(
              eventEntity: state.eventEntity,
            );
          } else if (state is TicketErrorState) {
            if (kDebugMode) {
              print(state.errorMessage);
            }
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
