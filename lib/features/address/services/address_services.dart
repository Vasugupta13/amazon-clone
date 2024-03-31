import 'dart:convert';
import 'package:amazon_clone/constants/error_handing.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final addressControllerProvider = Provider((ref) {
 return AddressServices(ref: ref);});

class AddressServices {
  final Ref _ref;
  AddressServices({required Ref ref}) : _ref = ref;
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final provider = _ref.read(userControllerProvider);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': provider.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = provider.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          _ref.read(userControllerProvider.notifier).setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  Future<void> placeOrder({
    required BuildContext context,
    required String address,
    required num totalSum,
  }) async {
    final provider = _ref.read(userControllerProvider);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': provider.token,
          },
          body: jsonEncode({
            'cartItems': provider.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          User user = provider.copyWith(
            cart: [],
          );
          _ref.read(userControllerProvider.notifier).setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final provider = _ref.read(userControllerProvider);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': provider.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}