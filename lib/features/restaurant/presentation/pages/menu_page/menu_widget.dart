import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';
import 'package:order/features/restaurant/presentation/cubit/restaurant_cubit.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final TextEditingController controllerMenuname = TextEditingController();
  final TextEditingController controllerMenuDescription =
      TextEditingController();
  final TextEditingController controllerItemPrice = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Item Name',
                    prefixIcon: Icon(Icons.restaurant_outlined),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill this form';
                    }
                  },
                  controller: controllerMenuname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Item Description',
                    prefixIcon: Icon(Icons.restaurant_outlined),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill this form';
                    }
                  },
                  controller: controllerMenuDescription,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Item Price',
                    prefixIcon: Icon(Icons.restaurant_outlined),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'please fill this form';
                    }
                  },
                  controller: controllerItemPrice,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(327, 56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: const Text('Add Item'),
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Item added successfully")));
                      context.read<RestaurantCubit>().addMenuItems(MenuModel(
                            name: controllerMenuname.text,
                            description: controllerMenuDescription.text,
                            price: int.parse(controllerItemPrice.text),
                          ));
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
