import 'package:amazon_clone/utils/config.dart';

class BasePaths {
  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseIcon = "assets/icons";
  static const basenotification = "assets/notification";
  static const baseProdUrl = "https://myfastx.api.ricoz.in";
  static const baseTestUrl = "https://emonoid.com/api/v1";
  static const socketTestUrl = "wss://emonoid.com";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
