import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:order/core/widgets/app_bar_widget.dart';

import '../../../cart/presentation/pages/view_order_page.dart';
import '../../../login/presentation/cubit/login_cubit.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../restaurant/presentation/cubit/restaurant_cubit.dart';
import '../../../restaurant/presentation/pages/add_restaurant_page.dart';
import '../../../restaurant/presentation/pages/get_all_restaurants_page/all_restaurants_page.dart';
import 'widgets/settings_details_row.dart';
import 'widgets/settings_header_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 16);
    return Scaffold(
      appBar: const AppBarWidget(
        pageName: "Settings",
        centerTitle: false,
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        const SettingsHeaderWidget(),
        sizedBox,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            sizedBox,
            SettingsDetailsRow(
              text: 'Your Orders',
              icon: Icons.text_snippet_outlined,
              onTap: () {
                context.read<RestaurantCubit>().getAllRestaurants();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ViewOrderPage()));
              },
            ),
            sizedBox,
            SettingsDetailsRow(
              text: 'Restaurants',
              icon: Icons.table_restaurant_outlined,
              onTap: () {
                context.read<RestaurantCubit>().getAllRestaurants();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AllRestaurantPage()));
              },
            ),
            sizedBox,
            SettingsDetailsRow(
              text: 'Add Restaurant',
              icon: Icons.add_box_outlined,
              onTap: () {
                Get.to(() => const RestaurantPage());
              },
            ),
            sizedBox,
            const Divider(
              thickness: 1,
              indent: 30,
            ),
            sizedBox,
            SettingsDetailsRow(
                icon: Icons.logout_outlined,
                isShowEndicon: false,
                text: 'Log out',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                  child: const Text("Confirm"),
                                  onPressed: () {
                                    setState(() {
                                      context.read<LoginCubit>().logOut();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    });
                                  })
                            ]);
                      });
                }),
          ]),
        ),
      ]),
    );
  }
}
