import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkProvider with ChangeNotifier {
  List<ConnectivityResult> _connectivityResult = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  NetworkProvider() {
    _initConnectivity();
  }

  List<ConnectivityResult> get connectivityResult => _connectivityResult;

  void _initConnectivity() async {
    try {
      _connectivityResult = await Connectivity().checkConnectivity();
      notifyListeners(); // 更新 UI

      // 监听网络状态变化
      _subscription = Connectivity().onConnectivityChanged.listen((result) {
        _connectivityResult = result;

        debugPrint('#### connectivity status: $_connectivityResult');

        notifyListeners(); // 更新 UI
      });
    } catch (e) {
      debugPrint('#### Couldn\'t check connectivity status: ${e.toString()}');
      return;
    }
  }

  bool hasAvailableNetwork() {
    
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      debugPrint('#### hasAvailableNetwork: mobile');
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      debugPrint('#### hasAvailableNetwork: wifi');
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      debugPrint('#### hasAvailableNetwork: ethernet');
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      debugPrint('#### hasAvailableNetwork: vpn');
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      debugPrint('#### hasAvailableNetwork: bluetooth');
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      debugPrint('#### hasAvailableNetwork: other');
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      debugPrint('#### hasAvailableNetwork: none');
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
