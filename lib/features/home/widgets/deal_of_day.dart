import 'package:amazon_clone/common/widgets/loader_widget.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DealOfDay extends ConsumerStatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  ConsumerState<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends ConsumerState<DealOfDay> {
  Product? product;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) => fetchDealOfDay());
  }

  void fetchDealOfDay() async {
    product = await ref.read(homeServiceProvider).fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            :
            GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$${product!.price.toString()}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        product!.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.network(
                                 e,
                                 fit: BoxFit.fitWidth,
                                 width: 100,
                                 height: 100,
                               ),
                              ),
                        )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}