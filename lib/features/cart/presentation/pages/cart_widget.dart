import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

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
  int count = 1;

  static double delivartFee = 25.00;
  static double serviceFee = 12.00;
  double total = delivartFee + serviceFee;

  Future<void> refresh() async {
    setState(() {
      final retrive = FirebaseFirestore.instance.collection("Cart");
      List<MenuModel> cartItems = [];
      retrive.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          cartItems.add(MenuModel.fromSnapShot(doc));
        }
      });
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
            onRefresh: refresh,
            child: ListView.separated(
              itemCount: widget.menuModel.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(7),
                  child: Card(
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.menuModel[index].name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "EGP: ${widget.menuModel[index].price * count}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            height: 5,
                            child: Divider(
                              thickness: 1,
                              color: Colors.orange,
                              indent: 5,
                              endIndent: 5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                            const Center(
                              child: SizedBox(
                                height: 60,
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: Colors.orange,
                                  endIndent: 20,
                                  indent: 5,
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 30,
                                child: InkWell(
                                    child: Text(
                                      count.toString(),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onTap: () {}),
                              ),
                            ),
                            const Center(
                              child: SizedBox(
                                height: 60,
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: Colors.orange,
                                  endIndent: 20,
                                  indent: 5,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _paymentSummary(
                              startName:
                                  "Total item after dilevry&services Fee",
                              endName:
                                  "EGP: ${widget.menuModel[index].price * count + delivartFee + serviceFee}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(thickness: 1),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 0, 10, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(327, 56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: const Text('Continous'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _paymentSummary({required String startName, required String endName}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        startName,
        style: const TextStyle(fontSize: 10, color: Colors.black54),
      ),
      Text(
        endName,
        style: const TextStyle(fontSize: 15),
      ),
    ],
  );
}
