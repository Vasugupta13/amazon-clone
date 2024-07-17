import 'dart:io';
import 'package:wick_wiorra/common/widgets/custom_button.dart';
import 'package:wick_wiorra/common/widgets/custom_textfiled.dart';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/constants/utils.dart';
import 'package:wick_wiorra/features/admin/services/admin_services.dart';
import 'package:wick_wiorra/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController burnTimeController = TextEditingController();

  String? category;
  String? waxType;
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Jar Candles',
    'Mould Candles',
    'Wide Jar Candles',
    'Small Candles',
  ];
  List<String> waxTypeList = [
    'Soy Wax',
    'Paraffin Wax',
    'Beeswax',
    'Palm Wax',
    'Carnauba Wax',
  ];
  List checkListItems = [
    {
      "value": false,
      "title": "Wild Lavender",
    },
    {
      "value": false,
      "title": "Holiday Cheer",
    },
    {
      "value": false,
      "title": "Sweet Caramel",
    },
    {
      "value": false,
      "title": "Hot Coffee",
    },
    {
      "value": false,
      "title": "Berry Blast",
    },
    {
      "value": false,
      "title": "Ocean Waves",
    },
    {
      "value": false,
      "title": "Coffee",
    },
    {
      "value": false,
      "title": "Rose",
    },
    {
      "value": false,
      "title": "Cinnamon",
    },
    {
      "value": false,
      "title": "Ocean Breeze",
    },
  ];
  List multipleSelected = [];
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      ref.read(adminControllerProvider).sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category!,
        images: images,
        availableFragrances: multipleSelected,
        burnTime: burnTimeController.text,
        netWeight: netWeightController.text,
        waxType: waxType!,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: burnTimeController,
                  hintText: 'Burn Time in minutes',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: netWeightController,
                  hintText: 'Net Weight in grams',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Select Candle type',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey.shade500),),

                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            category = newVal!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Select Wax type',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey.shade500),),
                        value: waxType,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: waxTypeList.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            waxType = newVal!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Text('Select Fragrances',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 16),),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio:5,
                      padding: EdgeInsets.zero,
                      children: List.generate(
                        checkListItems.length,
                            (index) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            checkListItems[index]["title"],
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          value: checkListItems[index]["value"],
                          onChanged: (value) {
                            setState(() {
                              checkListItems[index]["value"] = value;
                              if (multipleSelected.contains(checkListItems[index]['title'])) {
                                multipleSelected.remove(checkListItems[index]["title"]);
                              } else {
                                multipleSelected.add(checkListItems[index]["title"]);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      multipleSelected.isEmpty ? "" : multipleSelected.toString(),
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Sell',
                  onTap:() {
                    sellProduct();
                  },
                  color: GlobalVariables.secondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
