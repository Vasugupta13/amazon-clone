import 'package:amazon_clone/common/widgets/bottom_nav.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/payment/model/payment_initiate_response_model.dart';
import 'package:amazon_clone/features/payment/screens/post_payment_screen/payment_result_screen.dart';
import 'package:amazon_clone/features/payment/services/payment_api_service.dart';
import 'package:amazon_clone/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/parser.dart' show parse;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
class PaymentWebView extends ConsumerStatefulWidget {
  final num amount;
  const PaymentWebView({super.key, required this.amount});

  @override
  ConsumerState<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends ConsumerState<PaymentWebView> {
  late final WebViewController _controller;
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
               onProgress: (int progress) {
                 // Update loading bar.
               },
               // onPageStarted: (url){
               //   debugPrint('URL-----> $url');
               //   if(url == redirectUrl){
               //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const BottomNav()));
               //   }
               // },
               onPageFinished: (url) {
                 debugPrint('URL-----> $url');
                 // if(url == redirectUrl){
                 //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const BottomNav()));
                 // }
               },
               onNavigationRequest: (NavigationRequest request) {
                 if (request.url.toString() == redirectUrl) {
                   Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(builder: (context) => PaymentResult(merchantTransactionId: paymentRes!.data!.merchantTransactionId!)),
                   );
                   return NavigationDecision.prevent;
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
  // webViewInit() async{
  //   late final PlatformWebViewControllerCreationParams params;
  //   if (WebViewPlatform.instance is WebKitWebViewPlatform) {
  //     params = WebKitWebViewControllerCreationParams(
  //       allowsInlineMediaPlayback: true,
  //       mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
  //     );
  //   } else {
  //     params = const PlatformWebViewControllerCreationParams();
  //   }
  //
  //   final WebViewController controller =
  //   WebViewController.fromPlatformCreationParams(params);
  //   // #enddocregion platform_features
  //
  //   controller
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           debugPrint('WebView is loading (progress : $progress%)');
  //         },
  //         onPageStarted: (String url) {
  //           debugPrint('Page started loading: $url');
  //         },
  //         onPageFinished: (String url) {
  //           debugPrint('Page finished loading: $url');
  //         },
  //         onWebResourceError: (WebResourceError error) {
  //           debugPrint('''
  //            Page resource error:
  //            code: ${error.errorCode}
  //            description: ${error.description}
  //            errorType: ${error.errorType}
  //            isForMainFrame: ${error.isForMainFrame}
  //                    ''');
  //         },
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url.startsWith('https://www.youtube.com/')) {
  //             debugPrint('blocking navigation to ${request.url}');
  //             return NavigationDecision.prevent;
  //           }
  //           debugPrint('allowing navigation to ${request.url}');
  //           return NavigationDecision.navigate;
  //         },
  //         onUrlChange: (UrlChange change) {
  //           debugPrint('url change to ${change.url}');
  //         },
  //       ),
  //     )
  //     ..addJavaScriptChannel(
  //       'Toaster',
  //       onMessageReceived: (JavaScriptMessage message) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       },
  //     )
  //     ..loadRequest(Uri.parse('https://flutter.dev'));
  //
  //   // #docregion platform_features
  //   if (controller.platform is AndroidWebViewController) {
  //     AndroidWebViewController.enableDebugging(true);
  //     (controller.platform as AndroidWebViewController)
  //         .setMediaPlaybackRequiresUserGesture(false);
  //   }
  //   // #enddocregion platform_features
  //
  //   _controller = controller;
  // }
  @override
  void initState() {
    initAsync();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
    );
  }
}
