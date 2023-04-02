import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkChecker extends NetworkInfo{
  final InternetConnectionChecker connectionChecker;

  NetworkChecker({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}