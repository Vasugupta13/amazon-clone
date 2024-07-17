import 'package:wick_wiorra/features/order_details/screens/order_details_screen.dart';
import 'package:wick_wiorra/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserSingleProduct extends StatelessWidget {
  final List<Order> orders;
  const UserSingleProduct({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final image = order.products[0].images[0];
          final orderStatus = order.status;
          final orderedAt = order.orderedAt;
          final orderTotal = order.totalPrice;
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                OrderDetailScreen.routeName,
                arguments: orders[index],
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.fill
                          )
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderStatus == 0
                                ? "Pending "
                                : orderStatus == 1
                                    ? "Confirmed"
                                    : orderStatus == 2
                                        ? "Shipped"
                                        : "Delivered",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text("Ordered : ${DateFormat('dd MMM yy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(orderedAt),)}"),
                          Text("₹ $orderTotal"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
