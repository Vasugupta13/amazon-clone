import 'dart:convert';

class User {
 final String name;
 final String password;
 final String id;
 final String type;
 final String token;
final String email;
  User({
    required this.email,
    required this.name,
    required this.password,
    required this.id,
    required this.type,
    required this.token,
  });

    
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'id': id,
      'type': type,
      'token': token,
      'email': email,
    };
  } 

  factory User.fromJson(Map<String, dynamic> json,) {
    return User(  
    name : json['name'] ?? '',     
    password : json['password'] ?? '',
    id : json['_id'] ?? '',
    type : json['type'] ?? '',
    token : json['token'] ?? '',
    email:  json['email'] ?? '',
    );
  }

   String toJson() => json.encode(toMap());

   factory User.fromJsonString(String source) => User.fromJson(json.decode(source));
    User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }
}