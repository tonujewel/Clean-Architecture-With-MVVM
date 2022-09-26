
import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementer extends NetworkInfo {
 final DataConnectionChecker _dataConnectionChecker;

  NetworkInfoImplementer(this._dataConnectionChecker);
  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;
}
