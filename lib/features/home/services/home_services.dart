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
import 'package:wick_wiorra/utils/loader.dart';

final homeServiceProvider = StateNotifierProvider<HomeServices,HomeState>((ref) {
 final userRepo = ref.read(userControllerProvider);
 return HomeServices(userRepo: userRepo);
});

class HomeServices extends StateNotifier<HomeState> {
  final User _userRepo;
  HomeServices({required User userRepo}) : _userRepo = userRepo, super(HomeState(productsList: [], categoryProductsList: []));
  Future<List<ProductDetailModel>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    List<ProductDetailModel> productList = [];
    try {
      state = state.copyWith(loading: true);
      showLoader(context);
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
            state = state.copyWith(categoryProductsList: productList);
            Future.delayed(const Duration(milliseconds: 1500), () {
              state = state.copyWith(loading: false);
              hideLoading();
            });
          },

        );
      }
    } catch (e) {
      state = state.copyWith(loading: false,categoryProductsList: productList);
      hideLoading();
    }
    return productList;
  }

  Future<void> fetchProducts({
    required BuildContext context,
  }) async {
    List<ProductDetailModel> productList = [];
    try {
      state = state.copyWith(loading: true);
      showLoader(context);
      http.Response res = await http
          .get(Uri.parse('$uri/api/all-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': _userRepo.token,
      });
      print(res.body);
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
            state = state.copyWith(productDetailModel: productList);
            Future.delayed(const Duration(milliseconds: 1500), () {
              state = state.copyWith(loading: false);
              hideLoading();
            });
          },

        );

    } catch (e) {
      state = state.copyWith(loading: false,productDetailModel: productList);
      hideLoading();
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

}
class HomeState {
  final bool? loading;
  final List<ProductDetailModel> productsList;
  final List<ProductDetailModel> categoryProductsList;

  HomeState( {this.loading = false, required this.productsList,required this.categoryProductsList,});

  HomeState copyWith({
    bool? loading,
    List<ProductDetailModel>? productDetailModel,
    List<ProductDetailModel>? categoryProductsList,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      productsList: productDetailModel ?? this.productsList,
      categoryProductsList: categoryProductsList ?? this.categoryProductsList,
    );
  }
}