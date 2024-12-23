import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
