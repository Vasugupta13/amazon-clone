import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/payment/model/payment_initiate_response_model.dart';
import 'package:amazon_clone/features/payment/screens/post_payment_screen/payment_result_screen.dart';
import 'package:amazon_clone/features/payment/services/payment_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentWebView extends ConsumerStatefulWidget {
  final num amount;
  const PaymentWebView({super.key, required this.amount});

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
  initAsync () async {
    try{
      loadingMessage =
      "Please Do not close window,\nprocessing your request....";
      setState(() {});
       paymentRes = await ref.read(paymentControllerProvider.notifier).initiatePayment(widget.amount);
       currentUrl = paymentRes!.data!.instrumentResponse!.redirectInfo!.url!;
       redirectUrl = 'http://localhost:3000/redirect-url/${paymentRes!.data!.merchantTransactionId}';
       initialisePayment = true;
       setState(() {
         _controller = WebViewController()
           ..setJavaScriptMode(JavaScriptMode.unrestricted)
           ..setBackgroundColor(const Color(0x00000000))
           ..setNavigationDelegate(
             NavigationDelegate(
               onPageFinished: (url) {
                 if(url == currentUrl){
                   debugPrint('current URL-----> $url');
                 }
                 debugPrint('URL-----> $url');
               },
               onNavigationRequest: (NavigationRequest request) {
                 if (request.url.toString() == redirectUrl) {
                   if(context.mounted){
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(builder: (context) => PaymentResult(merchantTransactionId: paymentRes!.data!.merchantTransactionId!,amount: widget.amount)),
                     );
                   }
                 }
                 return NavigationDecision.navigate;
               },
             ),
           )
           ..loadRequest(Uri.parse(currentUrl));
       });
    }catch(e){
       errorMessage = "Something went wrong";
       setState(() {});
    }finally{
      loadingMessage = "";
      setState(() {});
    }
  }
  @override
  void initState() {
    initAsync();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: canGoBack,
      onPopInvoked: (invoked) async {
        if (canGoBack) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PaymentResult(merchantTransactionId: paymentRes!.data!.merchantTransactionId!,amount: widget.amount)),
          );
        } else {
          canGoBack = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to cancel payment'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
        body:initialisePayment?
           WebViewWidget(controller: _controller):
          (loadingMessage.isNotEmpty
            ?  Center(
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
