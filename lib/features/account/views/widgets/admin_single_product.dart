import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final bool isUserOrder;
  final String? orderDate;
  final String? orderTotal;
  final String? orderStatus;
  const SingleProduct({
    Key? key,
    required this.image, this.orderDate, this.orderTotal, this.isUserOrder = false, this.orderStatus,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}