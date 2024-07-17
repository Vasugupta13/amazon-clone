import 'dart:ui';
import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // This is the background that will be blurred
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),

          // This is the container that will be in the center
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/loader.png',height: 100,),
                          Positioned(
                            bottom: 65,
                            right: 25,
                            child: Lottie.network(
                                'https://lottie.host/da6b0f60-bc2d-44aa-a960-dbe23a96b71a/iz4v23QVpk.json',height: 40
                            ),
                          ),
                        ],
                      ),
                      const Text("Loading ...",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: GlobalVariables.kPrimaryTextColor),)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
OverlayEntry? _overlayEntry;
void showLoader(BuildContext context) {
  OverlayState overlayState = Overlay.of(context);
  _overlayEntry = OverlayEntry(
    builder: (context) => const LoaderWidget(),
  );
  overlayState.insert(_overlayEntry!);
}
void hideLoading() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}