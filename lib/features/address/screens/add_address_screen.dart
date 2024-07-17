import 'package:wick_wiorra/common/widgets/custom_textfiled.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  static const String routeName = '/addAddress';
  const AddAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddAddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddAddressScreen> {
  final TextEditingController addressLineController = TextEditingController();
  final TextEditingController cityTownController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String addressToBeUsed = "";
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    addressLineController.dispose();
    cityTownController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
  }

  void payPressed() {
    addressToBeUsed = "";

    bool isForm = addressLineController.text.isNotEmpty ||
        cityTownController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        stateController.text.isNotEmpty ||
        nameController.text.isNotEmpty ||
        phoneNumberController.text.isNotEmpty
    ;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${addressLineController.text}, ${cityTownController.text}, ${stateController.text} - ${pincodeController.text} - ${phoneNumberController.text} - ${nameController.text.toString()}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(addressControllerProvider.select((value) => value.loading));
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address",style: GoogleFonts.poppins(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
        backgroundColor: GlobalVariables.kPrimaryTextColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("  Add a new address",style: Theme.of(context).textTheme.headlineSmall ,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Form(
                      key: _addressFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            keyboardType: TextInputType.phone,
                            controller: phoneNumberController ,
                            hintText: 'Phone number',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: addressLineController,
                            hintText: 'Flat, House no, Building',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: cityTownController,
                            hintText: 'City/Town',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            keyboardType: TextInputType.phone,
                            controller: pincodeController,
                            hintText: 'Pincode',
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: stateController,
                            hintText: 'State',
                          ),
                          const SizedBox(height: 20),

                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: (){
                        payPressed();
                        if (_addressFormKey.currentState!.validate()) {
                          ref.read(addressControllerProvider.notifier).saveUserAddress(
                              context: context,
                              addressLine: addressLineController.text,
                              city: cityTownController.text,
                              addressState: stateController.text,
                              pincode: pincodeController.text,
                              name: nameController.text,
                              userNumber: phoneNumberController.text);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: GlobalVariables.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: GlobalVariables.kPrimaryTextColor,width: 1.2)
                        ),
                        child:  Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              !loading?  Text("Save Address",style: GoogleFonts.albertSans(
                              color: GlobalVariables.kPrimaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                              ) : const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}