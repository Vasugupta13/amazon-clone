import 'dart:convert';
import 'package:wick_wiorra/constants/error_handing.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/model/product.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productDetailProvider = StateProvider((ref) =>
    ProductDetailsServices(ref: ref));

class ProductDetailsServices {
  final Ref _ref;
  ProductDetailsServices({required Ref ref}) : _ref = ref;
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
