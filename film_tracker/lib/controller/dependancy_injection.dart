import 'package:film_tracker/controller/network_controller.dart';
import 'package:get/get.dart';

// DependancyInjection class is used for initializing and injecting dependencies
class DependancyInjection {
  // Initializes and injects the NetworkController into the dependency injection system
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}