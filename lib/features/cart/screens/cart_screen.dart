import 'package:wick_wiorra/features/cart/widgets/cart_provider.dart';
import 'package:wick_wiorra/features/home/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void navigateToSearchScreen(String query,BuildContext context) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Text('Wick & Wiorra',style: Theme.of(context).textTheme.headlineSmall,)
              ],
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 10),
          CartProduct(),
        ],
      ),
    );
  }
}