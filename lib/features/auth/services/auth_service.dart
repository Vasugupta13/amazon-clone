import 'dart:convert';
import 'package:wick_wiorra/common/widgets/bottom_nav.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
final authControllerProvider = Provider((ref) => AuthService(ref: ref));
class AuthService {
  final Ref _ref;

  AuthService({required Ref ref}) : _ref = ref;
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          name: name,
          password: password,
          id: '',
          type: 'user',
          token: '',
          email: email,);
      http.Response response = await http.post(
        Uri.parse('$uri/admin/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (!context.mounted) {
        return;
      }
      if(response.statusCode == 200) {
        showSnackBar(
          context,
          'Account created! Please login to continue',
        );
      }else if(response.statusCode == 400){
        jsonDecode(response.body)['message'];
        showSnackBar(
          context,
          jsonDecode(response.body)['message'],
        );
      }
    } catch (e) {
      debugPrint('$e');
      showSnackBar(context, "Unable to Sign Up currently!");
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200){
        showSnackBar(
          context,
          'Sign in successful!',
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (!context.mounted) {
          return;
        }
        _ref.read(userControllerProvider.notifier).setUser(response.body);
        await prefs.setString(
            'x-auth-token', jsonDecode(response.body)['token']);
        if (!context.mounted) {
          return;
        }
        Navigator.pushNamedAndRemoveUntil(
            context, BottomNav.routeName, (route) => false);
      }else if(response.statusCode == 400){
        jsonDecode(response.body)['message'];
        showSnackBar(
          context,
          jsonDecode(response.body)['message'],
        );
      }
    } catch (e) {
      debugPrint('$e');
      showSnackBar(context, "Unable to Sign in currently!");
    }
  }

  //get user data
  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        if (!context.mounted) {
          return;
        }
        _ref.read(userControllerProvider.notifier).setUser(userRes.body);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
