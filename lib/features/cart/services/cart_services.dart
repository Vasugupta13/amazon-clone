import 'dart:convert';
import 'package:wick_wiorra/constants/error_handing.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:wick_wiorra/model/user.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:wick_wiorra/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final cartProductController =StateNotifierProvider<CartServices, CartState>((ref)
{
  final userRepo = ref.read(userControllerProvider);
  return CartServices(userRepo: userRepo);
});

class CartServices extends StateNotifier<CartState> {
  final User _userRepo;
  CartServices({required User userRepo})
      : _userRepo = userRepo,
        super(CartState(
          cartItems: [],
        ));
  Future<void> addToCart({
    required BuildContext context,
    required ProductDetailModel product,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cartt'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userRepo.token
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final cartItem = jsonDecode(res.body)["products"];
          List<CartItemModel>? cartItems = [];
          if(res.statusCode == 200){
            for(var i in cartItem){
              cartItems.add(CartItemModel.fromJson(i));
            }
            state = state.copyWith(cartItems:cartItems,loading: false,total: _calculateTotal(items: cartItems));
            SnackBarService.showSnackBar(message: "Item added to cart!", context: context, backgroundColor: Colors.white,textColor: GlobalVariables.kPrimaryTextColor,duration: Duration(milliseconds: 500));
          }else{
            state = state.copyWith(loading: false);
          }
        },
      );
    } catch (e) {
      state = state.copyWith(loading: false);
      print('Exception during HTTP request: $e');
      showSnackBar(context, e.toString());
    }
  }

  void removeFromCart({
    required BuildContext context,
    required ProductDetailModel product,
  }) async {
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cartt'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userRepo.token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final cartItem = jsonDecode(res.body)["products"];
          List<CartItemModel>? cartItems = [];
          if(res.statusCode == 200){
            for(var i in cartItem){
              cartItems.add(CartItemModel.fromJson(i));
            }
            state = state.copyWith(cartItems:cartItems,loading: false,total: _calculateTotal(items: cartItems));
          }else{
            state = state.copyWith(loading: false);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Future<void> getAllItems({
    required BuildContext context,
  }) async {
    try {
      if (state.loading) {
        return;
      }
      state = state.copyWith(loading: true);
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userRepo.token
        },
      );
      final cartItem = jsonDecode(res.body)["products"];
      List<CartItemModel> cartItems = [];
      if(res.statusCode == 200){
        for(var i in cartItem){
          cartItems.add(CartItemModel.fromJson(i));
        }
        state = state.copyWith(
            cartItems:cartItems,
            loading: false,
            total: _calculateTotal(items: cartItems)
        );
      }else{
        state = state.copyWith(loading: false);
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      showSnackBar(context, e.toString());
      return Future.error(e);
    }
  }
  double _calculateTotal({required List<CartItemModel> items}) {
    double total = 0.0;
    for (CartItemModel item in items) {
      total = total + (item.product!.price! * item.quantity!);
    }
    return total;
  }
}

class CartState {
  final List<CartItemModel> cartItems;
  final bool loading;
  final num total;

  CartState({required this.cartItems, this.loading = false, this.total = 0.0,});

  CartState copyWith({
    List<CartItemModel>? cartItems,
    bool? loading,
    num? total,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      loading: loading ?? this.loading,
      total: total ?? this.total,
    );
  }
}
