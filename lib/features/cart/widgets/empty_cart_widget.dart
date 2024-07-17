import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 100),
        Center(child: Image.asset("assets/images/empty_cart.png", height: 250)),
        const SizedBox(height: 20),
        Text('No items in cart :(', style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}