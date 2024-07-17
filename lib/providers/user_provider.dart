import 'package:wick_wiorra/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userControllerProvider = StateNotifierProvider<UserProvider,User>((ref) {
  return UserProvider();
});
class UserProvider extends StateNotifier<User> {
  UserProvider(): super(User(
    name: '',
    password: '',
    id: '',
    type: '',
    token: '',
    email: '',
  ));

  void setUser(String user) {
    state = User.fromJsonString(user);
  }
  void setUserFromModel(User user) {
    state = user;
  }
}
