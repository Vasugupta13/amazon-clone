import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/cart/widgets/cart_list_widget.dart';
import 'package:wick_wiorra/features/cart/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProduct extends ConsumerWidget {
  const CartProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(cartProductController.select((value) => value.loading));
    final product = ref.watch(cartProductController.select((value) => value.cartItems));

    if (loading) {
      return const CircularProgressIndicator();
    } else if (product.isEmpty) {
      return const EmptyCartView();
    } else {
      return const CartListView();
    }
  }
}




