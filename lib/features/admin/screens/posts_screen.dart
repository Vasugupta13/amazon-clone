import 'package:wick_wiorra/common/widgets/loader_widget.dart';
import 'package:wick_wiorra/features/account/views/widgets/admin_single_product.dart';
import 'package:wick_wiorra/features/admin/screens/add_product_screen.dart';
import 'package:wick_wiorra/features/admin/services/admin_services.dart';
import 'package:wick_wiorra/model/product.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends  ConsumerState<PostsScreen> {
 List<Product>? products;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchAllProducts();
    });
  }

  fetchAllProducts() async {
      products = await ref.read(adminControllerProvider).fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    ref.read(adminControllerProvider).deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                      final productData = products![index];
                return Column(
                  children: [
                     SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                          deleteProduct(productData, index);
                },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => AddProductScreen()));
              },
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
