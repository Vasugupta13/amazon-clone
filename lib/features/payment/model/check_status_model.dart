class CheckStatusModel {
  bool? success;
  String? code;
  String? message;
  Data? data;

  CheckStatusModel({this.success, this.code, this.message, this.data});

  CheckStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? transactionId;
  int? amount;
  String? state;
  String? responseCode;
  PaymentInstrument? paymentInstrument;

  Data(
      {this.merchantId,
        this.merchantTransactionId,
        this.transactionId,
        this.amount,
        this.state,
        this.responseCode,
        this.paymentInstrument});

  Data.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantTransactionId = json['merchantTransactionId'];
    transactionId = json['transactionId'];
    amount = json['amount'];
    state = json['state'];
    responseCode = json['responseCode'];
    paymentInstrument = json['paymentInstrument'] != null
        ? PaymentInstrument.fromJson(json['paymentInstrument'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchantId'] = merchantId;
    data['merchantTransactionId'] = merchantTransactionId;
    data['transactionId'] = transactionId;
    data['amount'] = amount;
    data['state'] = state;
    data['responseCode'] = responseCode;
    if (paymentInstrument != null) {
      data['paymentInstrument'] = paymentInstrument!.toJson();
    }
    return data;
  }
}

class PaymentInstrument {
  String? type;
  String? cardType;
  String? pgTransactionId;
  String? bankTransactionId;
  String? pgAuthorizationCode;
  String? arn;
  String? bankId;
  String? brn;

  PaymentInstrument(
      {this.type,
        this.cardType,
        this.pgTransactionId,
        this.bankTransactionId,
        this.pgAuthorizationCode,
        this.arn,
        this.bankId,
        this.brn});

  PaymentInstrument.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    cardType = json['cardType'];
    pgTransactionId = json['pgTransactionId'];
    bankTransactionId = json['bankTransactionId'];
    pgAuthorizationCode = json['pgAuthorizationCode'];
    arn = json['arn'];
    bankId = json['bankId'];
    brn = json['brn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['cardType'] = cardType;
    data['pgTransactionId'] = pgTransactionId;
    data['bankTransactionId'] = bankTransactionId;
    data['pgAuthorizationCode'] = pgAuthorizationCode;
    data['arn'] = arn;
    data['bankId'] = bankId;
    data['brn'] = brn;
    return data;
  }
}
