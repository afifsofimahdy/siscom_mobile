// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const PRODUCT = _Paths.PRODUCT;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const PRODUCT = '/product';
  static const PRODUCT_ADD = '/product/add';
  static const PRODUCT_EDIT = '/product/edit';

}