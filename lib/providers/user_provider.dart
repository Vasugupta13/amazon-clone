import 'package:amazon_clone/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userControllerProvider = StateNotifierProvider<UserProvider,User>((ref) {
  return UserProvider();
});
class UserProvider extends StateNotifier<User> {
  UserProvider(): super(User(
    name: '',
    password: '',
    id: '',
    address: '',
    type: '',
    token: '',
    email: '',
    cart: [],
  ));

  void setUser(String user) {
    state = User.fromJsonString(user);
  }
  void setUserFromModel(User user) {
    state = user;
  }
}
