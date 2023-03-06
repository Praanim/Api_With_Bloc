import 'dart:async';

import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internetState_cubit.dart';
import 'package:api_bloc/constants/enum.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  InternetCubit() : super(InitialState()) {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile) {
        emit(InternetConnected(connectionType: ConnectionType.mobile));
      } else if (result == ConnectivityResult.wifi) {
        emit(InternetConnected(connectionType: ConnectionType.wifi));
      } else {
        emit(InternetDisconnectedState());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
