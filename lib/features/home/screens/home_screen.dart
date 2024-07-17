import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/home/search/screens/search_screen.dart';
import 'package:wick_wiorra/features/home/services/home_services.dart';
import 'package:wick_wiorra/features/home/widgets/carousel_images.dart';
import 'package:wick_wiorra/features/home/widgets/top_categories.dart';
import 'package:wick_wiorra/features/product_details/screens/product_detail_screen.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ProductDetailModel> product = [];
  void navigateToSearchScreen() {
    Navigator.pushNamed(context, SearchScreen.routeName,);
  }
  void navigateToProductDetails(ProductDetailModel product) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      ref.read(homeServiceProvider.notifier).fetchProducts(context: context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final products = ref.watch(homeServiceProvider.select((value) => value.productsList));
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Text('Wick & Wiorra',style: Theme.of(context).textTheme.headlineSmall,)
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discover',style: Theme.of(context).textTheme.displaySmall,),
                  GestureDetector(
                      onTap: navigateToSearchScreen,
                      child: SvgPicture.asset('assets/icons/searchIcon.svg',color: GlobalVariables.kPrimaryTextColor,))
                ],
              ),
            ),
            const SizedBox(height: 10),
            const TopCategories(),
            const SizedBox(height: 10),
            const CarouselImage(),
            // DealOfDay(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('All Candles',style: Theme.of(context).textTheme.titleLarge,),
                ],
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
                            child: Hero(
                              tag: products[index].id!,
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
                                    product: products[index],
                                );
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
      ),
    );
  }
}