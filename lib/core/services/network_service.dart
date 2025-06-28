import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// A service responsible for checking internet connectivity
class NetworkService {
  final Connectivity _connectivity = Connectivity();

  /// Stream to listen to real-time connectivity changes
  // Stream<ConnectivityResult> get onConnectivityChanged =>
  //     _connectivity.onConnectivityChanged;

  /// Returns true if the device is connected to the internet (Wi-Fi or mobile)
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  /// Returns a human-readable connection status
  Future<String> getConnectionType() async {
    final result = await _connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
        return 'Wi-Fi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.none:
        return 'No Connection';
      default:
        return 'Unknown';
    }
  }
}
