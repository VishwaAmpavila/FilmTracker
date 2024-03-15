import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// NetworkController class manages network connectivity status.
class NetworkController extends GetxController {
 final Connectivity _connectivity = Connectivity(); // Instance of Connectivity.

 @override
 void onInit() {
    super.onInit();
    // Listens for connectivity changes and updates the connection status accordingly.
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
 }
}

// Function to update the connection status
void _updateConnectionStatus(ConnectivityResult connectivityResult) {
 // If there is no connectivity, shows a snackbar asking the user to connect to the internet.
 if (connectivityResult == ConnectivityResult.none) {
    Get.rawSnackbar(
      messageText: const Text(
        'PLEASE CONNECT TO THE INTERNET',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        )
      ),
      isDismissible: false, // Snackbar cannot be dismissed by the user.
      duration: const Duration(days: 1), // Snackbar stays open for a long duration.
      backgroundColor: Colors.red[400]!,
      icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
      margin: EdgeInsets.zero, 
      snackStyle: SnackStyle.GROUNDED 
    );
 } else {
    // If there is connectivity and a snackbar is open, closes the snackbar.
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
 }
}