import 'package:wick_wiorra/model/cart.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final ProductDetailModel product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    product.images![0],
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.name!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '₹ ${product.price}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}