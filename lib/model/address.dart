// To parse this JSON data, do
//
//     final addressModel = addressModelFromMap(jsonString);

import 'dart:convert';

AddressModel addressModelFromMap(String str) => AddressModel.fromMap(json.decode(str));

String addressModelToMap(AddressModel data) => json.encode(data.toMap());

class AddressModel {
  final String? id;
  final String? userId;
  final List<AddressList>? addressList;
  final int? v;

  AddressModel({
    this.id,
    this.userId,
    this.addressList,
    this.v,
  });

  AddressModel copyWith({
    String? id,
    String? userId,
    List<AddressList>? addressList,
    int? v,
  }) =>
      AddressModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        addressList: addressList ?? this.addressList,
        v: v ?? this.v,
      );

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
    id: json["_id"],
    userId: json["userId"],
    addressList: json["addressList"] == null ? [] : List<AddressList>.from(json["addressList"]!.map((x) => AddressList.fromMap(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "userId": userId,
    "addressList": addressList == null ? [] : List<dynamic>.from(addressList!.map((x) => x.toMap())),
    "__v": v,
  };
}

class AddressList {
  final String? addressLine;
  final String? city;
  final String? state;
  final String? pincode;
  final String? name;
  final String? userNumber;
  final String? id;

  AddressList({
    this.addressLine,
    this.city,
    this.state,
    this.pincode,
    this.name,
    this.userNumber,
    this.id,
  });

  AddressList copyWith({
    String? addressLine,
    String? city,
    String? state,
    String? pincode,
    String? name,
    String? userNumber,
    String? id,
  }) =>
      AddressList(
        addressLine: addressLine ?? this.addressLine,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        name: name ?? this.name,
        userNumber: userNumber ?? this.userNumber,
        id: id ?? this.id,
      );

  factory AddressList.fromMap(Map<String, dynamic> json) => AddressList(
    addressLine: json["addressLine"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    name: json["name"],
    userNumber: json["userNumber"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "addressLine": addressLine,
    "city": city,
    "state": state,
    "pincode": pincode,
    "name": name,
    "userNumber": userNumber,
    "_id": id,
  };
}
