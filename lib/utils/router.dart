// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod_base/src/commons/views/splash2.dart';
// import 'package:flutter_riverpod_base/src/feature/auth/views/login.dart';
// import 'package:flutter_riverpod_base/src/feature/auth/views/otp_confirmation_view.dart';
// import 'package:flutter_riverpod_base/src/feature/auth/views/updateUser.dart';
// import 'package:flutter_riverpod_base/src/feature/chat/view/chat.dart';
// import 'package:flutter_riverpod_base/src/feature/customersupport/view/customer_support_view.dart';
// import 'package:flutter_riverpod_base/src/feature/driver/view/tracking_view.dart';
// import 'package:flutter_riverpod_base/src/feature/faqs/view/faqs.dart';
// import 'package:flutter_riverpod_base/src/feature/feedback/view/feedback.dart';
// import 'package:flutter_riverpod_base/src/feature/home/view/home.dart';
// import 'package:flutter_riverpod_base/src/feature/home/view/widgets/dropLocation.dart';
// import 'package:flutter_riverpod_base/src/feature/home/view/widgets/find_driver.dart';
// import 'package:flutter_riverpod_base/src/feature/home/view/widgets/pickupLocation.dart';
// import 'package:flutter_riverpod_base/src/feature/home/view/widgets/selection_page.dart';
// import 'package:flutter_riverpod_base/src/feature/notification/view/notification.dart';
// import 'package:flutter_riverpod_base/src/feature/order/view/widgets/orderdetails.dart';
// import 'package:flutter_riverpod_base/src/feature/order/view/orders_view.dart';
// import 'package:flutter_riverpod_base/src/feature/order/view/previeworder/view/preview_order.dart';
// import 'package:flutter_riverpod_base/src/feature/order/view/widgets/orderDeliverded.dart';
// import 'package:flutter_riverpod_base/src/feature/place%20order/view/place_order_view.dart';
// import 'package:flutter_riverpod_base/src/feature/pricing/view/pricing.dart';
//
// import 'package:flutter_riverpod_base/src/feature/profile/view/updateProfile.dart';
// import 'package:flutter_riverpod_base/src/feature/refer/view/refer.dart';
// import 'package:flutter_riverpod_base/src/feature/setting/views/setting.dart';
// import 'package:flutter_riverpod_base/src/feature/transaction%20success/view/transaction_success.dart';
// import 'package:flutter_riverpod_base/src/feature/transcations/view/transactions.dart';
// import 'package:go_router/go_router.dart';
//
// import '../feature/driver/view/widgets/voip.dart';
//
// final GoRouter router = GoRouter(
//
//   initialLocation: SplashView.routePath,
//   routes: [
//     GoRoute(
//       path: SplashView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const SplashView();
//       },
//     ),
//
//     GoRoute(
//       path: LoginView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const LoginView();
//       },
//     ),
//     GoRoute(
//       path: TrackingView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         final orderData = state.extra; // Replace OrderDataType with the actual type of your order data
//
//         return TrackingView(order: orderData);
//       },
//     ),
//     // GoRoute(
//     //   path: LoginView.routePath,
//     //   builder: (BuildContext context, GoRouterState state) {
//     //     return const LoginView();
//     //   },
//     // ),
//     GoRoute(
//       path: OtpConfirmationScreen.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return OtpConfirmationScreen(
//           phone: state.extra as String,
//         );
//       },
//     ),
//     GoRoute(
//       path: HomeView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const HomeView();
//       },
//     ),
//     GoRoute(
//       path: UpdateUser.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const UpdateUser();
//       },
//     ),
//     GoRoute(
//       path: PlaceOrderView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const PlaceOrderView();
//       },
//     ),
//     GoRoute(
//       path: MyOrdersView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const MyOrdersView();
//       },
//     ),
//     GoRoute(
//       path: OrdersDetailsView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const OrdersDetailsView();
//       },
//     ),
//     // GoRoute(
//     //   path: UpdateUser.routePath,
//     //   builder: (BuildContext context, GoRouterState state) {
//     //     return const UpdateUser();
//     //   },
//     // ),
//     GoRoute(
//       path: PickUpLocation.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const PickUpLocation();
//       },
//     ),
//     GoRoute(
//       path: UpdateProfileView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const UpdateProfileView();
//       },
//     ),
//     GoRoute(
//       path: CustomerSupportView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const CustomerSupportView();
//       },
//     ),
//     GoRoute(
//       path: FAQView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const FAQView();
//       },
//     ),
//     GoRoute(
//       path: SettingView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const SettingView();
//       },
//     ),
//     GoRoute(
//       path: ReferView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const ReferView();
//       },
//     ),
//     GoRoute(
//       path: StandardPricingView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const StandardPricingView();
//       },
//     ),
//     GoRoute(
//       path: ChatDriverView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const ChatDriverView();
//       },
//     ),
//     GoRoute(
//       path: OrderDeliveredView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const OrderDeliveredView();
//       },
//     ),
//     GoRoute(
//       path: NotificationView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const NotificationView();
//       },
//     ),
//     GoRoute(
//       path: FeedbackView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return FeedbackView(
//           driverId: (state.extra as Map)['driverId'],
//           orderId: (state.extra as Map)['orderId'],
//         );
//       },
//     ),
//     GoRoute(
//       path: SelectionPageView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const SelectionPageView();
//       },
//     ),
//     GoRoute(
//       path: DropLocation.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const DropLocation();
//       },
//     ),
//
//     GoRoute(
//     path: PreviewOrderView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const PreviewOrderView();
//       },
//     ),
//     GoRoute(
//       path: FindDriver.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const FindDriver();
//       },
//     ),
//     GoRoute(
//       path: TransactionsView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const TransactionsView();
//       },
//     ),
//     GoRoute(
//       path: TransactionSuccessView.routePath,
//       builder: (BuildContext context, GoRouterState state) {
//         return const TransactionSuccessView();
//       },
//     ),
//
//   ],
//
// );
