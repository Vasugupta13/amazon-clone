import 'dart:convert';

import 'package:wick_wiorra/constants/error_handing.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:wick_wiorra/model/user.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
final searchControllerProvider =Provider((ref) {
  final userProvider = ref.watch(userControllerProvider);
  return SearchServices( userProvider: userProvider);
});
class SearchServices {
  final User _userProvider;
  SearchServices({required User userProvider})
      : _userProvider = userProvider, super();
  Future<List<ProductDetailModel>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<ProductDetailModel> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': _userProvider.token,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              ProductDetailModel.fromJson(
                  jsonDecode(res.body)[i]
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}