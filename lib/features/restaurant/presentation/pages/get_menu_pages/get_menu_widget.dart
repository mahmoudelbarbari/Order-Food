import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/presentation/cubit/menu_cubit.dart';

class AllMenuWidget extends StatefulWidget {
  final List<MenuModel> menuModel;
  const AllMenuWidget({
    super.key,
    required this.menuModel,
  });

  @override
  State<AllMenuWidget> createState() => _AllMenuWidgetState();
}

class _AllMenuWidgetState extends State<AllMenuWidget> {
  Future<void> _refresh() async {
    setState(() {
      context.read<MenuCubit>().getAllMenu();
    });
    return Future.delayed(
      const Duration(seconds: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: widget.menuModel.length,
        itemBuilder: (_, index) {
          return ListTile(
            trailing: const Icon(Icons.add_shopping_cart),
            title: Text(widget.menuModel[index].name),
            subtitle: Text(widget.menuModel[index].price.toString()),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Added to your cart")));
              context
                  .read<CartCubit>()
                  .addProductToCart(widget.menuModel[index]);
            },
          );
        },
      ),
    );
  }
}
