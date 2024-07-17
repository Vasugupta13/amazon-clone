import 'package:wick_wiorra/common/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentResult extends ConsumerStatefulWidget {
  final String status;
  final num amount;
  final String? merchantTransactionId;
  const PaymentResult(
      {super.key,
      this.merchantTransactionId,
      required this.amount,
      required this.status});

  @override
  ConsumerState<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends ConsumerState<PaymentResult> {
  String success = '';
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((v) =>
        Navigator.pushNamedAndRemoveUntil(
            context, BottomNav.routeName, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.status == "PAYMENT_SUCCESS") ...{
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment Successful',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Icon(
                    Icons.verified,
                    color: Colors.lightGreen,
                    size: 100,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your order have been placed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            } else ...{
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment Failed',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.redAccent,
                    size: 100,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your order was not placed, Please try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            }
          ],
        ),
      ),
    );
  }
}
