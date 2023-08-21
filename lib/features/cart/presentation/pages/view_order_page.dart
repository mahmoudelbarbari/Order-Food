import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/app_bar_widget.dart';
import 'package:order/core/widgets/loading_widget.dart';
import 'package:order/core/widgets/snackbar_message.dart';
import 'package:order/features/cart/presentation/cubit/cart_state.dart';

import '../cubit/cart_cubit.dart';
import 'widgets/view_order_widget.dart';

class ViewOrderPage extends StatelessWidget {
  const ViewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(pageName: 'Your Orders'),
      body: BlocProvider(
        create: (context) => CartCubit()..viewOrder(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              FlutterToastMessageWidget().showErrorFlutterToast(
                  message: state.errorMessage, context: context);
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const LoadingWidget();
            } else if (state is CartItemsLoadded) {
              return ViewOrderWidget(menuModel: state.menuModel);
            }
            return const Center(
              child: Text(
                "You don't have any past orders...!",
                style: TextStyle(fontSize: 15),
              ),
            );
          },
        ),
      ),
    );
  }
}
