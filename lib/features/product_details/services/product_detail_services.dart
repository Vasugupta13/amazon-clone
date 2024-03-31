import 'dart:convert';
import 'package:amazon_clone/constants/error_handing.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productDetailProvider = StateProvider((ref) =>
    ProductDetailsServices(ref: ref));

class ProductDetailsServices {
  final Ref _ref;
  ProductDetailsServices({required Ref ref}) : _ref = ref;
  // void addToCart(
  //     {required BuildContext context,
  //       required Product product,
  //     }) async {
  //   final provider = _ref.read(userControllerProvider);
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/add-to-cart'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': provider.token
  //       },
  //       body: jsonEncode(
  //         {'id': product.id,},
  //       ),
  //     );
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () async {
  //           User user = _ref.read(userControllerProvider).copyWith(
  //             cart: jsonDecode(res.body)["cart"],
  //           );
  //           print(user);
  //           _ref.read(userControllerProvider.notifier).setUserFromModel(user);
  //         });
  //   } catch (e) {
  //     print('Exception during HTTP request: $e');
  //     showSnackBar(context, e.toString());
  //   }
  // }
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rate,
      }) async {
    final provider = _ref.read(userControllerProvider);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': provider.token
        },
        body: jsonEncode(
          {'id': product.id, 'rating': rate},
        ),
      );
      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
