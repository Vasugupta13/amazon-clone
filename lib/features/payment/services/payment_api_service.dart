import "dart:convert";
import "package:amazon_clone/constants/global_variables.dart";
import "package:amazon_clone/features/payment/model/check_status_model.dart";
import "package:amazon_clone/features/payment/model/payment_initiate_response_model.dart";
import "package:amazon_clone/model/user.dart";
import "package:amazon_clone/providers/user_provider.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart" as http;

final paymentControllerProvider = StateNotifierProvider<PaymentService,CheckStatusState>((ref) {
  final provider = ref.read(userProvider);
  return PaymentService(user: provider);
});

class PaymentService extends StateNotifier<CheckStatusState>{
  final User _userProvider;
  PaymentService({required User user}) : _userProvider = user,super(CheckStatusState());
  Future<PaymentRequestResponse> initiatePayment (num amount) async {
    try{
      Map<String, dynamic> bodyData = {
        "id":_userProvider.id,
        "amount":amount
      };
      http.Response response = await http.post(
        Uri.parse('$uri/pay'),
          body: json.encode(bodyData),
      headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': _userProvider.token,
      },
      );
      Map<String, dynamic> resData = json.decode(response.body);
      var paymentResponse = PaymentRequestResponse.fromJson(resData);
      if(paymentResponse.success!){
        return paymentResponse;
      }else {
        return Future.error(paymentResponse.message!);
      }
    }catch(e){
     return Future.error(e);
    }
  }
  Future<CheckStatusModel> checkStatus (String merchantTransactionId) async {
    try{
      if(state.loading){
        return Future.error('error');
      }
      state = state.copyWith(loading: true);
      http.Response response = await http.get(
        Uri.parse('$uri/redirect-url/$merchantTransactionId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': _userProvider.token,
        },
      );
      if(response.statusCode == 200){
        Map<String, dynamic> resData = json.decode(response.body);
        var statusResponse = CheckStatusModel.fromJson(resData);
        await Future.delayed(const Duration(seconds: 300));
        state = state.copyWith(loading: false,checkStatusModel: statusResponse);
        return statusResponse;
      }else {
        await Future.delayed(const Duration(seconds: 3));
        state = state.copyWith(loading: false);
        return Future.error('Something went wrong');
      }
    }catch(e){
      await Future.delayed(const Duration(seconds: 3));
      state = state.copyWith(loading: false,);
      return Future.error(e);
    }
  }
}
class CheckStatusState{
  final bool loading;
  final CheckStatusModel? checkStatusModel;
  CheckStatusState( {this.loading = false, this.checkStatusModel,});

  CheckStatusState copyWith({
    bool? loading,
    CheckStatusModel? checkStatusModel,
  }) {
    return CheckStatusState(
      loading: loading ?? this.loading,
      checkStatusModel: checkStatusModel ?? this.checkStatusModel,
    );
  }
}