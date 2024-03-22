import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/payment/model/check_status_model.dart';
import 'package:amazon_clone/features/payment/services/payment_api_service.dart';
import 'package:amazon_clone/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PaymentResult extends ConsumerStatefulWidget {
  final String merchantTransactionId;
  const PaymentResult( {super.key, required this.merchantTransactionId,});

  @override
  ConsumerState<PaymentResult> createState() => _PaymentResultState();
}

class _PaymentResultState extends ConsumerState<PaymentResult> {
  void onSuccessNavigate(){

  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      ref.read(paymentControllerProvider.notifier).checkStatus(widget.merchantTransactionId);
    });
  }
  @override
  Widget build(BuildContext context) {
    final paymentControllerState = ref.watch(paymentControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (paymentControllerState.loading) ...{
               Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Processing Payment',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 20,),
                  const SpinKitDoubleBounce(color: AppColors.darkcoplinkColor, size: 100,),
                  const SizedBox(height: 40,),
                  Text('Don\'t press back or home button.',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.redAccent.withOpacity(0.7)),),
                  const SizedBox(height: 20,),
                  const Text('Please wait while we are fetching\npayment status.',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                ],
              )
           }
            else if (paymentControllerState.checkStatusModel!.code == "PAYMENT_SUCCESS") ...{
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Payment Successful',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),
                  Center(child: Icon(Icons.verified, color: Colors.lightGreen, size: 100,)),
                  SizedBox(height: 20,),
                  Text('Your order have been placed.',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                ],
              )

            }
            else ...{
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Payment Failed',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                    SizedBox(height: 20,),
                    Center(child: Icon(Icons.cancel_outlined, color: Colors.redAccent, size: 100,)),
                    SizedBox(height: 20,),
                    Text('Your order was not placed, Please try again.',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                  ],
                )
              }
          ],
        ),
      ),
    );
  }
}
