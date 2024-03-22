import 'dart:convert';

class User {
 final String name;
 final String password;
 final String id;
 final String address;
 final String type;
 final String token;
final String email;
final List<dynamic> cart;
  User({
    required this.email,
    required this.name,
    required this.password,
    required this.id,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

    
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'id': id,
      'address': address,
      'type': type,
      'token': token,
      'email': email,
      'cart': cart,
    };
  } 

  factory User.fromJson(Map<String, dynamic> json,) {
    return User(  
    name : json['name'] ?? '',     
    password : json['password'] ?? '',
    id : json['_id'] ?? '',
    address : json['address'] ?? '',
    type : json['type'] ?? '',
    token : json['token'] ?? '',
    email:  json['email'] ?? '',
      cart: List<Map<String,dynamic>>.from(json['cart']?.map((x) => Map<String,dynamic>.from(x))),
    );
  }

   String toJson() => json.encode(toMap());

   factory User.fromJsonString(String source) => User.fromJson(json.decode(source));
    User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}