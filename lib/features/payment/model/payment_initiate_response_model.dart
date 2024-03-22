class PaymentRequestResponse {
  bool? success;
  String? code;
  String? message;
  Data? data;

  PaymentRequestResponse({this.success, this.code, this.message, this.data});

  PaymentRequestResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? merchantId;
  String? merchantTransactionId;
  InstrumentResponse? instrumentResponse;

  Data({this.merchantId, this.merchantTransactionId, this.instrumentResponse});

  Data.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantTransactionId = json['merchantTransactionId'];
    instrumentResponse = json['instrumentResponse'] != null
        ? InstrumentResponse.fromJson(json['instrumentResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchantId'] = merchantId;
    data['merchantTransactionId'] = merchantTransactionId;
    if (instrumentResponse != null) {
      data['instrumentResponse'] = instrumentResponse!.toJson();
    }
    return data;
  }
}

class InstrumentResponse {
  String? type;
  RedirectInfo? redirectInfo;

  InstrumentResponse({this.type, this.redirectInfo});

  InstrumentResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    redirectInfo = json['redirectInfo'] != null
        ? RedirectInfo.fromJson(json['redirectInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (redirectInfo != null) {
      data['redirectInfo'] = redirectInfo!.toJson();
    }
    return data;
  }
}

class RedirectInfo {
  String? url;
  String? method;

  RedirectInfo({this.url, this.method});

  RedirectInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['method'] = method;
    return data;
  }
}