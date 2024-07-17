import 'package:wick_wiorra/features/address/screens/add_address_screen.dart';
import 'package:wick_wiorra/features/address/services/address_services.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/payment/screens/payment_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String addressToBeUsed = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addressControllerProvider.notifier).getAddress(context: context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final loading = ref.watch(addressControllerProvider.select((value) => value.loading));
   final addressList = ref.watch(addressControllerProvider.select((value) => value.addressList));
   final selectedAddress = ref.watch(addressControllerProvider.select((value) => value.selectedAddress));
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Details",style: GoogleFonts.poppins(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
        backgroundColor: GlobalVariables.kPrimaryTextColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("  Select an Address",style: Theme.of(context).textTheme.headlineSmall ,),
              !loading ? ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addressList.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: GestureDetector(
                        onTap: (){
                         ref.read(addressControllerProvider.notifier).selectAddress(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(0, 0)
                              )
                            ],
                            border: Border.all(
                              color: selectedAddress == index ? GlobalVariables.kPrimaryTextColor : Colors.transparent
                            ),
                            color:selectedAddress == index ? GlobalVariables.kPrimaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(addressList[index].name!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Text(addressList[index].addressLine!),
                                Text("${addressList[index].city!},${addressList[index].pincode!}"),
                                Text(addressList[index].state!),
                                Text("Phone number : +91 ${addressList[index].userNumber!}"),
                                const SizedBox(height: 5,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }) :  const CircularProgressIndicator(),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddAddressScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.kPrimaryTextColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add a new address", style: GoogleFonts.albertSans(
                            color: GlobalVariables.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  final selected = addressList[selectedAddress];
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentWebView(
                    amount: widget.totalAmount,
                    name: selected.name!,
                    number: selected.userNumber!,
                    city: selected.city!,
                    addressLine: selected.addressLine!,
                    town: selected.state!,
                    pincode: selected.pincode!
                    ,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 1.2)
                  ),
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Proceed to Payment",
                          style: GoogleFonts.albertSans(
                            color: GlobalVariables.kPrimaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}