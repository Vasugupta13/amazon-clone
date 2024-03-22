import 'dart:convert';
import 'package:amazon_clone/utils/snackbar_service.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePayment extends StatefulWidget {
  const PhonePePayment({super.key});

  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {
 String environment = "UAT_SIM";
      String appId = '';
  String merchantId = 'PGTESTPAYUAT';
      bool enableLogging = true;
      String checksum = "";
      String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
      String saltKey = '099eb0cd-02cf-4e2a-8aca-3e6c6aff0399';
      String saltIndex = '1';
      String callBackUrl = 'https://webhook.site/1944f781-3281-468e-a34d-54d10a9b9f6a';
      String body = "";
      Object? result;
      String packageName = "com.example.amazon_clone";
      String apiEndPoint = "/pg/v1/pay";


 getChecksum(){
     final requestData = {
          "merchantId": merchantId,
        "merchantTransactionId": "transaction_123",
        "merchantUserId": "90223250",
        "amount": 1000,
        "mobileNumber": "9999999999",
        "callbackUrl": callBackUrl,
        "paymentInstrument": {"type": "PAY_PAGE",},
      };
      String base64Body = base64.encode(utf8.encode(jsonEncode(requestData)));
      checksum = '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey))}###$saltIndex';
      return base64Body;
      }
  @override
  void initState() {
    super.initState();
    phonePeInit();
   body = getChecksum().toString();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  void phonePeInit(){
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }
void startPgTransaction() async {
  PhonePePaymentSdk.startTransaction(body, callBackUrl, checksum, packageName).then((response) => {
    setState(() {
      if (response != null)
      {
        String status = response['status'].toString();
        String error = response['error'].toString();
        if (status == 'SUCCESS')
        {
          // "Flow Completed - Status: Success!";
          result = "Flow Completed - Status: Success!";
        }
        else {
          // "Flow Completed - Status: $status and Error: $error";
          result = "Flow Completed - Status: $status and Error: $error";
        }
      }
      else {
        // "Flow Incomplete";
        result = "Flow Incomplete";
      }
    })
  }).catchError((error) {
     handleError(error);
    return <dynamic>{};
  });

}

checkStatus()async {
   try {
     String url = 'https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId';
     String concatString = '/pg/v1/status/$merchantId/$transactionId$saltKey';
     var bytes = utf8.encode(concatString);
     var digest = sha256.convert(bytes).toString();
     String xVerify = "$digest###$saltIndex";
     Map<String,String> headers = {
          "Content_Type" : "application/json",
          "X-VERIFY" : xVerify,
          "X-MERCHANT-ID" : merchantId
        };
     await http.get(Uri.parse(url),headers: headers).then((value) {
            Map<String,dynamic> res =  jsonDecode(value.body);
          try{
            if(res["success"] && res["code"] == "PAYMENT_SUCCESS" && res['data']['state'] == "COMPLETED"){
              SnackBarService.showSnackBar(context: context, message: res['message'], backgroundColor: Colors.lightGreen);
            }else{
              SnackBarService.showSnackBar(context: context, message: 'Something went wrong!', backgroundColor: Colors.redAccent);
            }
          }catch(e){
            SnackBarService.showSnackBar(context: context, message: e.toString(), backgroundColor: Colors.redAccent);
          }
        });
   } catch (e) {
     handleError(e);
   }
}
  void handleError(error) {
    setState(() {
      result = {"error" : error};
    });
  }
}
