import 'package:wick_wiorra/common/widgets/bottom_nav.dart';
import 'package:wick_wiorra/features/address/screens/address_screen.dart';
import 'package:wick_wiorra/features/auth/screens/auth_screen.dart';
import 'package:wick_wiorra/features/home/screens/category_deals_screen.dart';
import 'package:wick_wiorra/features/home/screens/home_screen.dart';
import 'package:wick_wiorra/features/home/search/screens/search_screen.dart';
import 'package:wick_wiorra/features/order_details/screens/order_details_screen.dart';
import 'package:wick_wiorra/features/product_details/screens/product_detail_screen.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:wick_wiorra/model/order.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as num;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case BottomNav.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNav(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as ProductDetailModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}