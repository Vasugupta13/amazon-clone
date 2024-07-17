import 'dart:convert';
import 'package:wick_wiorra/constants/error_handing.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/model/address.dart';
import 'package:wick_wiorra/model/product.dart';
import 'package:wick_wiorra/model/user.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final addressControllerProvider =
    StateNotifierProvider<AddressServices, AddressState>((ref) {
  final userProvider = ref.watch(userControllerProvider);
  return AddressServices(userProvider: userProvider, ref: ref);
});

class AddressServices extends StateNotifier<AddressState> {
  final Ref _ref;
  final User _userProvider;
  AddressServices({required User userProvider, required Ref ref})
      : _userProvider = userProvider,
        _ref = ref,
        super(AddressState(addressList: []));
  void saveUserAddress({
    required BuildContext context,
    required String addressLine,
    required String city,
    required String addressState,
    required String pincode,
    required String name,
    required String userNumber,
  }) async {
    if (state.loading) {
      return;
    }
    state = state.copyWith(loading: true);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userProvider.token,
        },
        body: jsonEncode({
          'addressLine': addressLine,
          "city": city,
          "state": addressState,
          "pincode": pincode,
          "name": name,
          "userNumber": userNumber
        }),
      );
      List<AddressList> addressList = [];
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final jsonResponse = jsonDecode(res.body);
          final address = jsonResponse["addressList"];
          for (var i in address) {
            addressList.add(AddressList.fromMap(i));
          }
          state = state.copyWith(loading: false, addressList: addressList);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      state = state.copyWith(loading: false);
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getAddress({
    required BuildContext context,
  }) async {
    if (state.loading) {
      return;
    }
    state = state.copyWith(loading: true);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-all-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userProvider.token,
        },
      );
      List<AddressList> addressList = [];
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final jsonResponse = jsonDecode(res.body);
          final address = jsonResponse["addressList"];
          for (var i in address) {
            addressList.add(AddressList.fromMap(i));
          }
          state = state.copyWith(loading: false, addressList: addressList);
        },
      );
    } catch (e) {
      state = state.copyWith(loading: false,);
    //  showSnackBar(context, e.toString());
      return Future.error(e);
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

  void selectAddress(int index) {
    state = state.copyWith(selectedAddress: index);
  }
}

class AddressState {
  final bool loading;
  final List<AddressList> addressList;
  final int selectedAddress;

  AddressState({
    this.loading = false,
    required this.addressList,
    this.selectedAddress = 0,
  });

  AddressState copyWith({
    bool? loading,
    List<AddressList>? addressList,
    int? selectedAddress,
  }) {
    return AddressState(
      loading: loading ?? this.loading,
      addressList: addressList ?? this.addressList,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}
