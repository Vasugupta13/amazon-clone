import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProduct extends ConsumerStatefulWidget {
  const CartProduct({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends ConsumerState<CartProduct> {
  late final controller = ref.read(cartProductController.notifier);

  void increaseQuantity(ProductDetailModel product) {
    ref.read(cartProductController.notifier).addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(ProductDetailModel product) {
    ref.read(cartProductController.notifier).removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllItems(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Consumer(
      builder: (BuildContext context, WidgetRef watch, Widget? child) {
        final loading =
        watch.watch(cartProductController.select((value) => value.loading));
        final product = watch.watch(cartProductController.select((value) => value.cartItems));
        if(loading){
          return const CircularProgressIndicator();
        }else{
         return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) {
                final products = product[index].product;
                final quantity = product[index].quantity;
                if(product.isEmpty){
                  return const Text('Empty cart');
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            products!.images![0],
                            fit: BoxFit.contain,
                            height: 135,
                            width: 135,
                          ),
                          Column(
                            children: [
                              Container(
                                width: 235,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  products.name!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: 235,
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  '\$${products.price}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: 235,
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text('Eligible for FREE Shipping'),
                              ),
                              Container(
                                width: 235,
                                padding: const EdgeInsets.only(left: 10, top: 5),
                                child: const Text(
                                  'In Stock',
                                  style: TextStyle(
                                    color: Colors.teal,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black12,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => decreaseQuantity(products),
                                  child: Container(
                                    width: 35,
                                    height: 32,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.remove,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12, width: 1.5),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Container(
                                    width: 35,
                                    height: 32,
                                    alignment: Alignment.center,
                                    child: Text(
                                      quantity.toString(),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => increaseQuantity(products),
                                  child: Container(
                                    width: 35,
                                    height: 32,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.add,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },

            ),
          );
        }
      },);
  }
}