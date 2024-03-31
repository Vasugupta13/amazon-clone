import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNav extends ConsumerStatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends ConsumerState<BottomNav> {
  late final controller = ref.read(cartProductController.notifier);
   int _page = 0;
  double bottomNavBarWidth = 42;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    //ProfileScreen(),
    //CartScreen(),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
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
    //final userCartLen = ref.watch(userProvider).cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          //HOME
          BottomNavigationBarItem(  
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : Colors.transparent,
                      width: 5),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          //PROFILE
           BottomNavigationBarItem(  
        
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : Colors.transparent,
                      width: 5),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          //CART
           BottomNavigationBarItem(  
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : Colors.transparent,
                      width: 5),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.white,
                  padding: EdgeInsets.all(2),
                ),
                badgeContent: Consumer(
                builder: (context, watch, child) {
                  final product =  watch.watch(cartProductController.select((value) => value.cartItems));
               //  print(cart.cartItems.length);
                   return Text('${product.length}');
                  },
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
      ),
    );
  }
}
