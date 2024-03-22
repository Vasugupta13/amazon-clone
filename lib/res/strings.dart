/// Contains all the strings used accross the app.
/// Avoid hard coding strings.
/// All the strings must be added in this file.
/// ```dart
/// class AppStrings{
///  static const appName = "Riverpod app template";
///}
///```

class AppStrings {
  static const appName = "Riverpod app template";
}

class FailureMessage {
  static const getRequestMessage = "GET REQUEST FAILED";
  static const postRequestMessage = "POST REQUEST FAILED";
  static const putRequestMessage = "PUT REQUEST FAILED";
  static const deleteRequestMessage = "DELETE REQUEST FAILED";

  static const jsonParsingFailed = "FAILED TO PARSE JSON RESPONSE";

  static const authTokenEmpty = "AUTH TOKEN EMPTY";

  static const failedToParseJson = "Failed to Parse JSON Data";
}

class AuthenticationMessages {
  static const otpSendSuccessfully = "OTP Sent Successfully";
  static const otpSendFailed = "Failed To Send OTP";
  static const otpVerificationFailed = "Failed To Verify OTP";
  static const otpVerificationSuccess = "OTP Successfully Verified";
}

class UserProfile {
  static const nameEmpty = "Name can't be empty";
  static const updateFailed = "Failed to update profile";
  static const updateSuccess = "Profile updated successfully";
}

class SnackBarMessages {
  static const productLoadSuccess = "Products Loaded Successfully";
  static const productLoadFailed = "Failed To Load Products";
}

class LogLabel {
  static const product = "PRODUCT";
  static const auth = "AUTH";
  static const httpGet = "HTTP/GET";
  static const httpPost = "HTTP/POST";
  static const httpPut = "HTTP/PUT";
  static const httpDelete = "HTTP/DELETE";
  static const sharedPrefs = "SHARED_PREFERENCES";
}
class CheckOut{
  List<String> items = [
    'Now',
    '10 min',
    '30 min',
  ];
}
