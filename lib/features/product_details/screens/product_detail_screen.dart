import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/home/search/screens/search_screen.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = '/product-details';
  final ProductDetailModel product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
   String selectedFragrance= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.kPrimaryTextColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: Hero(
                tag: widget.product.id!,
                child: Swiper(
                  pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: GlobalVariables.kPrimaryColor,
                          activeColor: GlobalVariables.kPrimaryTextColor,
                          size: 10.0,
                          activeSize: 12.0)),
                  itemCount: widget.product.images!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      widget.product.images![index],
                      fit: BoxFit.fill,
                    );
                  },
                  scale: 0.9,
                  autoplay: false,
                  indicatorLayout: PageIndicatorLayout.SCALE,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.product.name!,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "MRP inclusive of all taxes",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    "₹ ${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select fragrance",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              child: Wrap(
                spacing: 8.0, // gap between adjacent chips
                runSpacing: 8.0, // gap between lines
                children: widget.product.availableFragrances!.map((String fragrance) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedFragrance = fragrance;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:selectedFragrance != fragrance ? GlobalVariables.kPrimaryColor : GlobalVariables.kPrimaryTextColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 1)
                      ),child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                        child: Text(fragrance,style:  TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: selectedFragrance != fragrance ? GlobalVariables.kPrimaryTextColor : GlobalVariables.kPrimaryColor ),),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Product Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Table(
                border: TableBorder(
                    horizontalInside: const BorderSide(color: Colors.black),
                    verticalInside: const BorderSide(color: Colors.black),
                    top: const BorderSide(color: Colors.black),
                    bottom: const BorderSide(color: Colors.black),
                    right: const BorderSide(color: Colors.black),
                    left: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(4)),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: Text("Net weight",style: TextStyle(fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        child: Text("${widget.product.netWeight} gms",style: const TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: Text("Burn Time",style: TextStyle(fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        child: Text("${widget.product.burnTime} minutes",style: const TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: Text("Wax Type",style: TextStyle(fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        child: Text("${widget.product.waxType}",style: const TextStyle(fontSize: 12),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.description!,
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            ref.read(cartProductController.notifier).addToCart(
                  context: context,
                  product: widget.product,
                );
          },
          child: Container(
            decoration: BoxDecoration(
              color: GlobalVariables.kPrimaryTextColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              "Add to Cart",
              style: GoogleFonts.albertSans(
                  color: GlobalVariables.kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )),
          ),
        ),
      ),
    );
  }
}
