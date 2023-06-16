import 'package:get/get.dart';

class themeController extends GetxController{
    bool islight = true;

    lightTheme() {
      islight = true;
      update();
    }
    darkTheme() {
      islight = false;
      update();
}
}

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => themeController());
  }}