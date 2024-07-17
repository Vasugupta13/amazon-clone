import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/cart/widgets/cart_item_widget.dart';
import 'package:wick_wiorra/features/cart/widgets/cart_subtotal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListView extends StatelessWidget {
  const CartListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cart', style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, _){
              final product = ref.watch(cartProductController.select((value) => value.cartItems));
              return Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: product.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final products = product[index].product;
                      final quantity = product[index].quantity;
                      return CartItemView(products: products, quantity: quantity!);
                    },
                  ),
                  const CartSubtotal(),
                ],
              );
            },
          ),

        ],
      ),
    );
  }
}