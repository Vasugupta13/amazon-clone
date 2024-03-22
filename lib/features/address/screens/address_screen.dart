import 'dart:convert';
import 'package:amazon_clone/features/payment/screens/payment_web_view.dart';
import 'package:amazon_clone/features/payment/services/payment_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/common/widgets/custom_textfiled.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/features/payment/screens/phonepe_payment.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/utils/snackbar_service.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay/pay.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class AddressScreen extends ConsumerStatefulWidget {
  static const String routeName = '/address';
  final num totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final _addressFormKey = GlobalKey<FormState>();

  String environment = "SANDBOX";
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
  String packageName = "";
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
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum = '${sha256.convert(utf8.encode(base64Body+apiEndPoint+saltKey)).toString()}###$saltIndex';
    return base64Body;
  }
  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount.toString(),
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
    phonePeInit();
    body = getChecksum().toString();
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
  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (ref.read(userProvider).address.isEmpty) {
      ref.read(addressControllerProvider).saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    ref.read(addressControllerProvider).placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: widget.totalAmount,
    );
  }

  void onGooglePayResult(res) {
    if (ref.read(userProvider).address.isEmpty) {
      ref.read(addressControllerProvider).saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    ref.read(addressControllerProvider).placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: widget.totalAmount,
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Future<PaymentConfiguration> _googlePayConfig =
    // PaymentConfiguration.fromAsset('gpay.json');
    // final Future<PaymentConfiguration> _applePayConfig =
    // PaymentConfiguration.fromAsset('applepay.json');
    var address = ref.read(userProvider).address;
    var userId = ref.read(userProvider).id;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
               ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentWebView(amount: widget.totalAmount,)));
               }, child: const Text('Proceed to Payment')),
            ],
          ),
        ),
      ),
    );
  }
}