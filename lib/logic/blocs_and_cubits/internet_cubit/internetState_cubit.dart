import 'package:api_bloc/constants/enum.dart';

abstract class InternetState {}

class InitialState extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;
  InternetConnected({
    required this.connectionType,
  });
}

class InternetDisconnectedState extends InternetState {}
