import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/home/search/services/search_services.dart';
import 'package:wick_wiorra/features/home/search/widget/search_widget.dart';
import 'package:wick_wiorra/features/product_details/screens/product_detail_screen.dart';
import 'package:wick_wiorra/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const String routeName = '/search-screen';
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<ProductDetailModel>? products;

  fetchSearchedProduct(String query) async {
    products = await ref.read(searchControllerProvider).fetchSearchedProducts(
        context: context, searchQuery: query,);
    setState(() {});
  }

  void navigateToProductDetails(ProductDetailModel product) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onChanged: (query){
                        if(query.isEmpty){
                          
                         }else{
                          fetchSearchedProduct(query);
                        }

                      },
                      cursorColor: GlobalVariables.kPrimaryTextColor,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10,left: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: GlobalVariables.kPrimaryTextColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: GlobalVariables.kPrimaryTextColor,
                            width: 1.4,
                          ),
                        ),
                        hintText: 'Search candles....',
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color:Colors.grey.shade300
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? Center(child: Text("Search for candles...",style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 16,fontWeight: FontWeight.w500),))
          : Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        navigateToProductDetails(products![index]);
                      },
                      child: SearchedProduct(
                        product: products![index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}