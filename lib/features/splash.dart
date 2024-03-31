import 'package:amazon_clone/common/widgets/bottom_nav.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/services/auth_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      ref.read(authControllerProvider).getUserData(context: context).then((value) {
        final token = ref.read(userControllerProvider).token;
        final userType = ref.read(userControllerProvider).type;
        if(token.isEmpty){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const AuthScreen()));
        }else{
          if(userType == 'user'){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const BottomNav()));
          }else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const AdminScreen()));
          }
        }
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/amazon_in.png')
        ],
      ),
    );
  }
}
