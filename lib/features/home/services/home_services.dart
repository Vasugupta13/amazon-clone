import 'dart:convert';
import 'package:amazon_clone/constants/error_handing.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final homeServiceProvider = Provider((ref) {
 final userRepo = ref.read(userControllerProvider);
 return HomeServices(userRepo: userRepo);
});

class HomeServices {
  final User _userRepo;
  HomeServices({required User userRepo}) : _userRepo = userRepo;
  Future<List<ProductDetailModel>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    List<ProductDetailModel> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': _userRepo.token,
      });
      if (context.mounted) {
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
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    return productList;
  }

  Future<ProductDetailModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    ProductDetailModel product = ProductDetailModel(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-the-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': _userRepo.token,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = ProductDetailModel.fromJson(jsonDecode(res.body));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
