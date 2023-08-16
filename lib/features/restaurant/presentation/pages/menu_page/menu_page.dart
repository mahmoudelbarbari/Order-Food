import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/app_bar_widget.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_state.dart';
import 'package:order/features/restaurant/presentation/pages/menu_page/menu_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  RegisterAccountEntity registerAccountEntity = RegisterAccountEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageName: 'Add Menu Restaurant',
        centerTitle: false,
        hideBackButton: true,
      ),
      body: BlocProvider<RestaurantCubit>(
        create: (context) => RestaurantCubit(),
        child: BlocConsumer<RestaurantCubit, RestaurantState>(
          listener: (context, state) {
            if (state is CreateRestaurantSuccessfully) {
              registerAccountEntity = state.registerAccountEntity;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.registerAccountEntity.message ??
                      "Added Successfully")));
            }
            if (state is RestaurantError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return const MenuWidget();
          },
        ),
      ),
    );
  }
}
