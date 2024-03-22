import 'package:amazon_clone/res/base.dart';

/// Contains all the API endpoints used in the application.
/// Example :
///
/// An endpoint can be used the following way
/// ```dart
/// final response = await http.get(Endpoints.getUser)
/// ```

class Endpoints {
  static const _base = BasePaths.baseUrl;

  static const socketTestUrl_ = BasePaths.socketTestUrl;

  static const register = "$_base/user/registration";

  static const verifyOtp = "$_base/user/verification";
  static const updateProfile = "$_base/user/profile/update/info";

  static const faqQuestion = "$_base/faq/allfaq";

  static const vehicles = "$_base/vehicle/allVehiclesPricing";

  static const transactions = "$_base/user/orderHistory";

  static const fetchVehicles = "$_base/vehicle/allVehicles";

  static const createOrder = "$_base/order/create";

  static const verifyPayment = "$_base/order/verifyPayment";
  static const getUploadUrl = "$_base/storage/uploadurl";

  //

  static const base = BasePaths.baseUrl;
}

class StorageUrl {
  static const _baseStorage =
      "https://pub-67026bebe3ba4b1385a2e05550bea538.r2.dev";
  static const baseAvatar = "$_baseStorage/AVATAR";
}
