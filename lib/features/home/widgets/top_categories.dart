import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical:10),
      child: Row(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children : [
          GestureDetector(
            onTap: (){navigateToCategoryPage(context, 'Jar Candles');},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: GlobalVariables.kPrimaryColor,
                  child: ImageIcon(AssetImage('assets/images/candle.png'),color: GlobalVariables.kPrimaryTextColor,size: 90,)),
            ),
          ),
          GestureDetector(
            onTap: (){navigateToCategoryPage(context, 'Mould Candles');},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: GlobalVariables.kPrimaryColor,
                  child: ImageIcon(AssetImage('assets/images/mold_candle.png'),color: GlobalVariables.kPrimaryTextColor,size: 90,)),
            ),
          ),
          GestureDetector(
            onTap: (){navigateToCategoryPage(context, 'Small Candles');},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: GlobalVariables.kPrimaryColor,
                  child: ImageIcon(AssetImage('assets/images/candles.png'),color: GlobalVariables.kPrimaryTextColor,size: 90,)),
            ),
          ),
          GestureDetector(
            onTap: (){navigateToCategoryPage(context, 'Wide Jar Candles');},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: GlobalVariables.kPrimaryColor,
                  child: ImageIcon(AssetImage('assets/images/wide_jar_candle.png'),color: GlobalVariables.kPrimaryTextColor,size: 90,)),
            ),
          ),
        ],
      ),
    );
  }
}