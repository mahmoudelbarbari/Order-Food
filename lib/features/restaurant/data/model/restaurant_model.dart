import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String restaurantName;
  String restaurantDescription;
  String hotlineNum;

  RestaurantModel({
    required this.restaurantName,
    required this.hotlineNum,
    required this.restaurantDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'restaurantName': restaurantName,
      'hotlineNum': hotlineNum,
      'restaurantDescription': restaurantDescription,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      restaurantName: map['restaurantName'],
      hotlineNum: map['hotlineNum'],
      restaurantDescription: map['restaurantDescription'],
    );
  }

  factory RestaurantModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return RestaurantModel(
      restaurantName: documentSnapshot.data()!['restaurantName'],
      restaurantDescription: documentSnapshot.data()!['restaurantDescription'],
      hotlineNum: documentSnapshot.data()!['restaurantHotline'],
    );
  }
}

class MenuModel {
  String name;
  String description;
  int price;
  int? quentity;

  MenuModel({
    required this.name,
    required this.description,
    required this.price,
    this.quentity,
  });

  factory MenuModel.fromSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return MenuModel(
      name: queryDocumentSnapshot.data()['name'] ?? '',
      description: queryDocumentSnapshot.data()['description'] ?? '',
      price: queryDocumentSnapshot.data()['price'] ?? '',
      quentity: queryDocumentSnapshot.data()['quentity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory MenuModel.fromMap(DocumentSnapshot<Object?> map) {
    return MenuModel(
      name: map['name'],
      description: map['description'],
      price: map['price'],
      quentity: map['quentity'],
    );
  }
}

class ImageURLModel {
  String imageURL;

  ImageURLModel({required this.imageURL});

  factory ImageURLModel.fromSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return ImageURLModel(
      imageURL: queryDocumentSnapshot.data()['imageURL'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageURL': imageURL,
    };
  }

  factory ImageURLModel.fromMap(DocumentSnapshot<Object?> map) {
    return ImageURLModel(
      imageURL: map['imageURL'],
    );
  }
}
