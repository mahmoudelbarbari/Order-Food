import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/app_bar_widget.dart';
import 'package:order/core/widgets/snackbar_message.dart';
import 'package:order/features/register/domain/entities/register_entities.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_state.dart';
import 'package:order/features/restaurant/presentation/pages/add_restaurant_widget.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  RegisterAccountEntity registerAccountEntity = RegisterAccountEntity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        pageName: "Add restaurants",
        centerTitle: false,
      ),
      body: BlocProvider<RestaurantCubit>(
        create: (context) => RestaurantCubit(),
        child: BlocConsumer<RestaurantCubit, RestaurantState>(
          listener: (context, state) {
            if (state is CreateRestaurantSuccessfully) {
              FlutterToastMessageWidget().showSuccessFlutterToast(
                  message: "Restaurant added seccessfuly :)", context: context);
              registerAccountEntity = state.registerAccountEntity;
            }

            if (state is RestaurantError) {
              FlutterToastMessageWidget().showErrorFlutterToast(
                  message: "You must choose an image..!", context: context);
            }
          },
          builder: (context, state) {
            return const RestaurantWidget();
          },
        ),
      ),
    );
  }
}
