import 'dart:convert';

import 'package:wick_wiorra/model/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;
  final List<dynamic> availableFragrances;
  final String burnTime;
  final String netWeight;
  final String waxType;
  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      required this.burnTime,
      required this.netWeight,
      required this.waxType,
        required this.availableFragrances,
      this.id,
      this.rating,
      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
      'burnTime':burnTime,
      'netWeight':netWeight,
      'waxType':waxType,
      'availableFragrances':availableFragrances,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
        map['ratings']?.map(
              (x) => Rating.fromMap(x),
        ),
      )
          : null,
      burnTime: map['burnTime'] ?? '0',
      netWeight: map['netWeight'] ?? '100',
      waxType: map['waxType'] ?? "Soy Wax",
      availableFragrances: List<String>.from(map['availableFragrances']),
    );
  }
  String toJson() => jsonEncode(toMap());

  factory Product.fromJson(String source)=>
      Product.fromMap(jsonDecode(source));
}
