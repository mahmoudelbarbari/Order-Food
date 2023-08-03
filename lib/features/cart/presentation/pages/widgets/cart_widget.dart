import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

import 'bottom_container_cart_widget.dart';
import 'cart_items_container.dart';

class CartWidget extends StatefulWidget {
  final List<MenuModel> menuModel;
  const CartWidget({
    super.key,
    required this.menuModel,
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  static double delivartFee = 25.00;
  static double serviceFee = 12.00;
  double total = delivartFee + serviceFee;

  Future<void> _refresh() async {
    setState(() {
      context.read<CartCubit>().getAllCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: widget.menuModel.length,
              itemBuilder: (context, index) {
                const center = Center(
                  child: Divider(
                    thickness: 1,
                    color: Colors.orange,
                    indent: 5,
                    endIndent: 5,
                  ),
                );
                return CartItemsContainer(
                  center: center,
                  title: widget.menuModel[index].name,
                  subTitle: widget.menuModel[index].price,
                );
              },
              separatorBuilder: (context, index) => const Divider(thickness: 1),
            ),
          ),
        ),
        const BottomContainerCartWidget(),
      ],
    );
  }
}
