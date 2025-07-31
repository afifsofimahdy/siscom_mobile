import 'package:get/get.dart';
import 'package:siscom_mobile/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.PRODUCT);
    });
  }
}