import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/address/screens/address_screen.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CartSubtotal extends ConsumerWidget {
  const CartSubtotal({
    super.key,
  });
  void navigateToAddress(num sum, BuildContext context) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartLength =
        ref.watch(cartProductController.select((value) => value.cartItems));
    final total =
        ref.watch(cartProductController.select((value) => value.total));
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Subtotal ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "₹ $total",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => navigateToAddress(total, context),
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalVariables.kPrimaryTextColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                      child: Text(
                    'Proceed to Buy (${cartLength.length} items)',
                    style: GoogleFonts.albertSans(
                        color: GlobalVariables.kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
