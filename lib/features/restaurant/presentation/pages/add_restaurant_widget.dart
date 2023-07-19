import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:order/features/restaurant/presentation/pages/menu_page/menu_page.dart';

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
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Restaurant Name',
                    prefixIcon: Icon(Icons.restaurant_outlined),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill this form';
                    }
                  },
                  controller: controllerRestaurantname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Restaurant Description',
                    prefixIcon: Icon(Icons.text_snippet),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill this form';
                    }
                  },
                  controller: _controllerRestaurantDescription,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Restaurant Hotline',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  controller: controllerRestaurantHotline,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(327, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text('Upload restaurant picture'),
              onPressed: () {
                context.read<RestaurantCubit>().uploadImage();
              },
            ),
          ),
          isPressed == false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(327, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text('Add restaurant'),
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate()) {
                        isPressed = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content:
                                    Text("Restaurant added successfully")));
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
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(327, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text('Add menu'),
                  onPressed: () {
                    setState(() {
                      isPressed = false;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MenuPage(),
                      ));
                    });
                  },
                ),
        ],
      ),
    );
  }
}
