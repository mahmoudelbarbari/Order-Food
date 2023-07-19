import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/event/presentation/cubit/ticket_cubit.dart';
import 'package:order/features/event/presentation/pages/ticket_page.dart';
import 'package:order/features/login/presentation/cubit/login_cubit.dart';
import 'package:order/features/login/presentation/pages/login_page.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/add_restaurant_page.dart';
import 'package:order/features/restaurant/presentation/pages/get_all_restaurants_page/all_restaurants_page.dart';

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
                //buildHeader(context),
                buildMenuItems(context),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
            right: 80,
            left: 10),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(6, 10, 100, 15),
                child: CircleAvatar(
                  radius: 40,
                ),
              ),
              Text(
                'Mohamed Mamdouh \n',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'M.Kamel123@gmail.com',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Wrap(
        //runSpacing: 5,
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
          const Divider(color: Color.fromRGBO(255, 255, 255, 0.08)),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text(
              'Log out',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              context.read<LoginCubit>().logOut();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
            },
          ),
        ],
      );
}
