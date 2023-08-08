import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/pages/ticket_page.dart';
import 'package:order/features/login/presentation/pages/login_page.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/add_restaurant_page.dart';
import 'package:order/features/restaurant/presentation/pages/get_all_restaurants_page/all_restaurants_page.dart';

import '../features/login/presentation/cubit/login_cubit.dart';

class NavigationDrawerr extends StatelessWidget {
  const NavigationDrawerr({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: ListView(
          children: [
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
                buildMenuItems(context),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Wrap(
        children: <Widget>[
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              context.read<TicketCubit>().getAllTickets();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TicketPage()));
            },
          ),
          ListTile(
            title: const Text('Restaurants'),
            leading: const Icon(Icons.restaurant),
            onTap: () {
              context.read<RestaurantCubit>().getAllRestaurants();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AllRestaurantPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_rounded),
            title: const Text(
              'Add Restaurant',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RestaurantPage()));
            },
          ),
          const Divider(
            thickness: 1,
            indent: 30,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Log out',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: const Text("Confirm"),
                          onPressed: () async {
                            context.read<LoginCubit>().logOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      );
}
