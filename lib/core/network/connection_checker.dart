import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class ConnectionChecker {
  Future<bool> isConnected();
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnectionChecker internetConnection;

  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> isConnected() async {
    return await internetConnection.hasConnection;
  }
}
