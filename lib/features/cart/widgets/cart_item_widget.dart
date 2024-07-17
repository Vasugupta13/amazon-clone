import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/cart.dart';

class CartItemView extends StatelessWidget {
  final ProductDetailModel? products;
  final int quantity;
  const CartItemView({Key? key, this.products, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Image.network(
              products!.images![0],
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products!.name!,
                  style: const TextStyle(
                      fontSize: 16, color: GlobalVariables.kPrimaryTextColor),
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    '₹ ${products!.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: GlobalVariables.kPrimaryTextColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: GlobalVariables.kLightPrimaryTextColor,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(cartProductController.notifier)
                                        .removeFromCart(
                                          context: context,
                                          product: products!,
                                        );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: GlobalVariables.kPrimaryTextColor,
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: GlobalVariables.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Text(
                                        quantity.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(cartProductController.notifier)
                                        .addToCart(
                                          context: context,
                                          product: products!,
                                        );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: GlobalVariables.kPrimaryTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ); // Placeholder for actual implementation
  }
}
