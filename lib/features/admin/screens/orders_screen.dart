
import 'package:wick_wiorra/common/widgets/loader_widget.dart';
import 'package:wick_wiorra/features/account/views/widgets/admin_single_product.dart';
import 'package:wick_wiorra/features/admin/services/admin_services.dart';
import 'package:wick_wiorra/features/order_details/screens/order_details_screen.dart';
import 'package:wick_wiorra/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
 List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
   orders = await ref.read(adminControllerProvider).fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
     orders == null
        ? const Loader()
        :
        GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
             final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                   OrderDetailScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: orderData.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
