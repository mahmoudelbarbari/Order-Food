import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/get_menu_pages/get_menu_page.dart';

import 'common_container_restaurant_widget.dart';

class AllRestaurantWidget extends StatefulWidget {
  final List<RestaurantModel> restaurantModel;
  const AllRestaurantWidget({
    super.key,
    required this.restaurantModel,
  });

  @override
  State<AllRestaurantWidget> createState() => _AllRestaurantWidgetState();
}

class _AllRestaurantWidgetState extends State<AllRestaurantWidget> {
  Future<void> _refresh() async {
    setState(() {
      context.read<RestaurantCubit>().getAllRestaurants();
    });
    return Future.delayed(
      const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
          itemCount: widget.restaurantModel.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(7),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AllMenuPage()));
                },
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      CommonContainerRestaurantWidget(
                        text: widget.restaurantModel[index].restaurantName,
                        iconData: Icons.restaurant_menu,
                        isShowEndicon: true,
                      ),
                      CommonContainerRestaurantWidget(
                        text:
                            widget.restaurantModel[index].restaurantDescription,
                        iconData: Icons.restaurant_menu,
                        isShowEndicon: false,
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      CommonContainerRestaurantWidget(
                        text: widget.restaurantModel[index].hotlineNum,
                        iconData: Icons.phone,
                        isShowEndicon: true,
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 1);
          }),
    );
  }
}
