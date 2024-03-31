import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSubtotal extends ConsumerWidget {
   const CartSubtotal({super.key,});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cartLength = ref.watch(cartProductController.select((value) => value.cartItems));
    final total = ref.watch(cartProductController.select((value) => value.total));
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Subtotal ',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                total.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Proceed to Buy (${cartLength.length} items)',
              onTap: (){},
              //=> navigateToAddress(sum),
              color: Colors.yellow[600],
            ),
          ),
        ],
      ),
    );
  }
}