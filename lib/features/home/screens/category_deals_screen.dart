import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/home/services/home_services.dart';
import 'package:wick_wiorra/features/product_details/screens/product_detail_screen.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDealsScreen extends ConsumerStatefulWidget{
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends ConsumerState<CategoryDealsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      ref.read(homeServiceProvider.notifier).fetchCategoryProducts(context: context, category: widget.category);
    });
  }
  void navigateToProductDetails(ProductDetailModel product) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(homeServiceProvider.select((value) => value.categoryProductsList));
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Text(widget.category,style: Theme.of(context).textTheme.headlineSmall,)
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for ${widget.category}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight:FontWeight.w600
              ),
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                childAspectRatio: 0.65,
                crossAxisSpacing: 4
            ),
            itemCount: products.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: (){
                    navigateToProductDetails(products[index]);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        flex:12,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            image:  DecorationImage(
                                image: NetworkImage(products[index].images![0]),fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(products[index].name!,style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('${products[index].netWeight!} gms',style: GoogleFonts.albertSans(fontSize:12,fontWeight:FontWeight.w600,color:Colors.grey.shade500)),
                        ],
                      ),
                      Expanded(
                        flex:2,
                        child: Row(
                          children: [
                            Text("₹ ${products[index].price!}",style: Theme.of(context).textTheme.bodyLarge,),
                          ],
                        ),
                      ),
                      Expanded(
                        flex:2,
                        child: GestureDetector(
                          onTap: (){
                            ref.read(cartProductController.notifier).addToCart(
                              context: context,
                              product: products[index],);
                          },
                          child: Container(decoration: BoxDecoration(
                            color: GlobalVariables.kPrimaryTextColor,
                            borderRadius: BorderRadius.circular(10),
                          ),child: Center(child: Text("Add to Cart",style: GoogleFonts.albertSans(color:GlobalVariables.kPrimaryColor,fontSize:14,fontWeight:FontWeight.w600),)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}