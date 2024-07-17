import 'dart:convert';
import 'dart:developer';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/payment/model/check_status_model.dart';
import 'package:wick_wiorra/features/payment/model/payment_initiate_response_model.dart';
import 'package:wick_wiorra/features/payment/screens/post_payment_screen/payment_result_screen.dart';
import 'package:wick_wiorra/features/payment/services/payment_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends ConsumerStatefulWidget {
  final num amount;
  final String name;
  final String number;
  final String city;
  final String addressLine;
  final String town;
  final String pincode;
  const PaymentWebView({
    super.key,
    required this.amount,
    required this.name,
    required this.number,
    required this.city,
    required this.addressLine,
    required this.town,
    required this.pincode,
  });

  @override
  ConsumerState<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends ConsumerState<PaymentWebView> {
  late final WebViewController _controller;
  bool canGoBack = false;
  PaymentRequestResponse? paymentRes;
  String currentUrl = "";
  String loadingMessage = "";
  String errorMessage = "";
  String redirectUrl = '';
  bool initialisePayment = false;
  initAsync() async {
    try {
      loadingMessage =
          "Please Do not close window,\nprocessing your request....";
      setState(() {});
      paymentRes =
          await ref.read(paymentControllerProvider.notifier).initiatePayment(
                amount: widget.amount,
                addressLine: widget.addressLine,
                name: widget.name,
                number: widget.number,
                city: widget.city,
                town: widget.town,
                pincode: widget.pincode,
              );
      currentUrl = paymentRes!.data!.instrumentResponse!.redirectInfo!.url!;
      redirectUrl = '$uri/redirect-url/';
      initialisePayment = true;
      setState(() {
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                if (url == currentUrl) {
                  debugPrint('current URL-----> $url');
                } else if (url == '$uri/redirect-url/') {
                  debugPrint('redirect URL-----> $url');
                  final Object htmlContent = await _controller
                      .runJavaScriptReturningResult('document.body.innerText');
                  final parsedJson = parse(htmlContent);
                  final jsonData = parsedJson.body?.text;
                  _controller.clearCache();
                  final result = jsonDecode(jsonDecode(jsonData!));
                  log(result.toString());
                  final status =
                      CheckStatusModel.fromJson(result['paymentResponse']);
                  if (status.code == "PAYMENT_SUCCESS") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentResult(
                                amount: widget.amount,
                                status: status.code!,
                              )),
                    );
                  } else if (status.code == "PAYMENT_ERROR") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentResult(
                                amount: widget.amount,
                                status: status.code!,
                              )),
                    );
                  }
                }
                debugPrint('URL-----> $url');
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.toString() == redirectUrl) {}
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(currentUrl));
      });
    } catch (e) {
      errorMessage = "Something went wrong";
      setState(() {});
    } finally {
      loadingMessage = "";
      setState(() {});
    }
  }

  @override
  void initState() {
    initAsync();
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canGoBack,
      onPopInvoked: (invoked) async {
        if (canGoBack) {
          Navigator.pop(context);
        } else {
          canGoBack = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: GlobalVariables.kPrimaryTextColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "Payment",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: initialisePayment
            ? WebViewWidget(controller: _controller)
            : (loadingMessage.isNotEmpty
                ? Center(
                    child: Text(loadingMessage),
                  )
                : (errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    : const SizedBox.shrink())),
      ),
    );
  }
}
