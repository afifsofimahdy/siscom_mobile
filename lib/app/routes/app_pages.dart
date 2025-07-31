// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:siscom_mobile/app/modules/product/bindings/product_binding.dart';
import 'package:siscom_mobile/app/modules/product/views/product_view.dart';
import 'package:siscom_mobile/app/modules/splash/bindings/splash_binding.dart';
import 'package:siscom_mobile/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
  ];
}