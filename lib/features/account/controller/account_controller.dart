import 'dart:convert';
import 'package:wick_wiorra/constants/error_handing.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/features/auth/screens/auth_screen.dart';
import 'package:wick_wiorra/model/order.dart';
import 'package:wick_wiorra/model/user.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final accountControllerProvider = StateNotifierProvider<AccountServices,OrderState>((ref) {
  final userRepo = ref.read(userControllerProvider);
  return AccountServices(userRepo: userRepo);
});
class AccountServices extends StateNotifier<OrderState>{
  final User _userRepo;
  AccountServices({required User userRepo}): _userRepo = userRepo,
  super(OrderState(
  orderList: [],
  ));

  Future<void> fetchMyOrders({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];
    try {
      if(state.loading){
        return;
      }
      state = state.copyWith(loading: true);
      http.Response res =
      await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': _userRepo.token,
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          state = state.copyWith(loading: false, orderList: orderList);
        },
      );
    } catch (e) {
      state = state.copyWith(loading: false, orderList: orderList);
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
            (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
class OrderState {
  final List<Order> orderList;
  final bool loading;

  OrderState({required this.orderList, this.loading = false});

  OrderState copyWith({
    List<Order>? orderList,
    bool? loading,
  }) {
    return OrderState(
      orderList: orderList ?? this.orderList,
      loading: loading ?? this.loading,
    );
  }
}