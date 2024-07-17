import 'package:wick_wiorra/features/account/controller/account_controller.dart';
import 'package:wick_wiorra/features/account/views/widgets/orders.dart';
import 'package:wick_wiorra/features/profile/screens/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account',style: Theme.of(context).textTheme.displaySmall,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const ProfileView()));
                  },
                  splashFactory: NoSplash.splashFactory,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline_outlined),
                        SizedBox(width: 10,),
                        Text("Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_forward_ios,size: 18,),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                InkWell(
                  onTap:() =>Navigator.push(context, MaterialPageRoute(builder: (_)=>const Orders())),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Icon(Icons.local_shipping_outlined),
                        SizedBox(width: 10,),
                        Text("Orders",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_forward_ios,size: 18,),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Icon(Icons.headset_mic_outlined),
                      SizedBox(width: 10,),
                      Text("Help and Support",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward_ios,size: 18,),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline_rounded),
                      SizedBox(width: 10,),
                      Text("Privacy Policy",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward_ios,size: 18,),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_rounded),
                      SizedBox(width: 10,),
                      Text("About",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                      Expanded(child: SizedBox()),
                      Icon(Icons.arrow_forward_ios,size: 18,),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                InkWell(
                  onTap: (){
                    ref.read(accountControllerProvider.notifier).logOut(context);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Icon(Icons.logout_rounded,color: Colors.redAccent,),
                        SizedBox(width: 10,),
                        Text("Log out",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.redAccent),),
                        Expanded(child: SizedBox()),
                        Icon(Icons.arrow_forward_ios,size: 18,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}