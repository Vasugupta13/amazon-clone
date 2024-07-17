import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userName = ref.read(userControllerProvider).name;
    final userEmail = ref.read(userControllerProvider).email;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: GlobalVariables.kPrimaryTextColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title:  Text("Profile",style: GoogleFonts.poppins(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w500),),
        ),
      ),
      body: SafeArea(
        child:Column(
          children: [
            const SizedBox(height: 20,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Icon(CupertinoIcons.profile_circled,color: GlobalVariables.kLightPrimaryTextColor,size:150,)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(children: [
                Text("Username"),
              ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: GlobalVariables.kLightPrimaryTextColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        child: Text(userName),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(children: [
                Text("Email"),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: GlobalVariables.kLightPrimaryTextColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        child: Text(userEmail),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Row(children: [
                Text("Password"),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: GlobalVariables.kLightPrimaryTextColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 0.5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                        child: Text("xxxxxxxxx"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
