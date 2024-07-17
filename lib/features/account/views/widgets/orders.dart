import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/account/controller/account_controller.dart';
import 'package:wick_wiorra/features/account/views/widgets/user_single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    ref.read(accountControllerProvider.notifier).fetchMyOrders(context: context);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(accountControllerProvider.select((value) => value.loading));
    final orders = ref.watch(accountControllerProvider.select((value) => value.orderList));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.kPrimaryTextColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "My Orders",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: !loading && orders.isEmpty
          ? const Text("No orders currently") :
          loading ? const Center(child: CircularProgressIndicator(color: GlobalVariables.kPrimaryTextColor,),)
          : UserSingleProduct(orders: orders,)
    );
  }
}
