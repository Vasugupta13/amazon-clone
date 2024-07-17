import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/account/views/account_screen.dart';
import 'package:wick_wiorra/features/cart/screens/cart_screen.dart';
import 'package:wick_wiorra/features/cart/services/cart_services.dart';
import 'package:wick_wiorra/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends ConsumerStatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends ConsumerState<BottomNav> {
  late final controller = ref.read(cartProductController.notifier);
   int _page = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
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
      body: IndexedStack(
          index: _page,
          children: pages),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 7,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        items: [
          //HOME
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/homeIcon.svg',width: 32,
              color:  _page == 0
                ? GlobalVariables.kPrimaryTextColor
                : GlobalVariables.kPrimaryTextColor.withOpacity(0.6),
            ),
            label: '',
          ),
          //PROFILE
           BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg',width: 30,
              color:  _page == 1
                  ? GlobalVariables.kPrimaryTextColor
                  : GlobalVariables.kPrimaryTextColor.withOpacity(0.6),),
            label: '',
          ),
          //CART
           BottomNavigationBarItem(
            icon: badges.Badge(
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
              child: SvgPicture.asset('assets/icons/shoppingBag.svg',width: 30,
                color:  _page == 2
                    ? GlobalVariables.kPrimaryTextColor
                    : GlobalVariables.kPrimaryTextColor.withOpacity(0.6),)
            ),
            label: '',
          ),
        ],
        currentIndex: _page,
        backgroundColor: GlobalVariables.backgroundColor,
        onTap: updatePage,
      ),
    );
  }
}
