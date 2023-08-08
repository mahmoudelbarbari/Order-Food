import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/core/widgets/common_elevated_button_widget.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/widget/add_menu_button_widget.dart';
import 'package:order/features/restaurant/presentation/pages/widget/header_container_add_restaurant_widget.dart';
import 'package:order/features/restaurant/presentation/pages/widget/hotline_restaurant_textfield_widget.dart';
import 'package:order/features/restaurant/presentation/pages/widget/restaurant_textfield_widget.dart';

import 'menu_page/menu_page.dart';

class RestaurantWidget extends StatefulWidget {
  const RestaurantWidget({super.key});

  @override
  State<RestaurantWidget> createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  bool isPressed = false;

  final TextEditingController controllerRestaurantname =
      TextEditingController();
  final TextEditingController _controllerRestaurantDescription =
      TextEditingController();
  final TextEditingController controllerRestaurantHotline =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    const divider = Divider(
      thickness: 1,
      indent: 30,
      endIndent: 30,
      color: Colors.amber,
    );
    return Form(
      key: formKey,
      child: ListView(children: [
        sizedBox,
        divider,
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UnderlineTextWidget(text: "- Restaurant Details."),
              sizedBox,
              RestaurantTextFieldWidget(
                  controllerRestaurant: controllerRestaurantname,
                  labelText: "Name"),
              sizedBox,
              RestaurantTextFieldWidget(
                  controllerRestaurant: _controllerRestaurantDescription,
                  labelText: "Description"),
              sizedBox,
              HotLineRestaurantTextFieldWidget(
                  controllerRestaurantHotline: controllerRestaurantHotline),
            ],
          ),
        ),
        sizedBox,
        divider,
        CommonElevatedButton(
          text: 'Upload restaurant picture',
          onTap: () {
            context.read<RestaurantCubit>().uploadImage();
          },
        ),
        isPressed == false
            ? CommonElevatedButton(
                text: "Add restaurant",
                onTap: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      isPressed = true;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Restaurant added successfully")));
                      context.read<RestaurantCubit>().addRestaurant(
                            RestaurantModel(
                              restaurantName: controllerRestaurantname.text,
                              restaurantDescription:
                                  _controllerRestaurantDescription.text,
                              hotlineNum: controllerRestaurantHotline.text,
                            ),
                          );
                    }
                  });
                },
              )
            : AddMenuButtonWidget(
                onTap: () {
                  setState(() {
                    isPressed = false;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MenuPage(),
                    ));
                  });
                },
              )
      ]),
    );
  }
}
