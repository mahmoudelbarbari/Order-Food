import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/drawer_menu.dart';
import 'package:order/core/error/widgets/loading_widget.dart';
import 'package:order/features/cart/presentation/pages/cart_page.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/cubit/ticket_state.dart';
import 'package:order/features/event/presentation/pages/ticket_widget.dart';
import 'package:order/features/event/presentation/pages/widgets/event_add_update_pages/event_add_update_page.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

String greetings() {
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
          'Welcome, ${greetings()}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      drawer: const NavigationDrawerr(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
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

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const EventAddUpdatePage(
                      isUpdateEvent: false,
                    )));
      },
      child: const Icon(
        Icons.border_color_rounded,
        color: Colors.white,
      ),
    );
  }
}
