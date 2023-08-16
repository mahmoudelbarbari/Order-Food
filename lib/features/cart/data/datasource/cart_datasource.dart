import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order/features/cart/data/models/cart_items_model.dart';
import 'package:order/features/event/domain/entities/event_entities.dart';
import 'package:order/features/restaurant/data/model/restaurant_model.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatasourceProvider._internal();
}

abstract class CartDatasourceInterface extends FirebaseDatasourceProvider {
  CartDatasourceInterface() : super._internal();

  Future<BaseResponse> addProductToCart(MenuModel menuModel);
  Future<BaseResponse> addCartData(CartItemModel cartItemModel);
  Future<List<MenuModel>> getAllCartItems();
}

class CartDatasourceImpl extends CartDatasourceInterface {
  CartDatasourceImpl() : super();

  @override
  Future<BaseResponse> addProductToCart(MenuModel menuModel) async {
    try {
      // await firebaseFirestore.collection('Cart').add({
      //   'cart': FieldValue.arrayUnion([menuModel.toMap()])
      // });
      await firebaseFirestore.collection('Cart').doc().set({
        'name': menuModel.name,
        'price': menuModel.price,
      });
      await firebaseFirestore.collection('Order saves').doc().set({
        'name': menuModel.name,
        'price': menuModel.price,
      });
      return BaseResponse(
          status: true,
          message: "Item added , ${menuModel.name} was added to your cart");
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<BaseResponse> addCartData(CartItemModel cartItemModel) async {
    try {
      await firebaseFirestore.collection("checkoutList").doc().set({
        'name': cartItemModel.name,
        'price': cartItemModel.price,
        'quantity': cartItemModel.quantity,
      });
      return BaseResponse(
          status: true,
          message: "Item added , ${cartItemModel.name} to checkout list");
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<List<MenuModel>> getAllCartItems() async {
    final retrive = firebaseFirestore.collection('Cart');
    final querySnapshot = await retrive.get();
    querySnapshot.docs.map((e) => e.data()).toList();
    List<MenuModel> cartItems = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      cartItems.add(MenuModel.fromSnapShot(doc));
    }
    return cartItems;
  }
}
