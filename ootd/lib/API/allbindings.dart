import 'package:get/get.dart';
import 'package:ootd/API/notification.dart';
class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}