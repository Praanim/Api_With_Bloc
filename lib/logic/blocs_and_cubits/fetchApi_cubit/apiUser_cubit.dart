import 'dart:async';

import 'package:api_bloc/data/models/user_models.dart';
import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internetState_cubit.dart';
import 'package:api_bloc/constants/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api_bloc/logic/blocs_and_cubits/fetchApi_cubit/api_User_cubit_state.dart';
import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internet_cubit.dart';
import 'package:api_bloc/data/repository/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  final InternetCubit _internetCubit;

  StreamSubscription? internetSubscription;
  UserCubit(
    this._userRepository,
    this._internetCubit,
  ) : super(UserLoadingState()) {
    monitorInternetConnection();
  }

  // continously checking internet connection in the app

  void monitorInternetConnection() {
    internetSubscription = _internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected) {
        emit(Connection_State(connectionType: internetState.connectionType));
        getUserFromApi();
      } else if (internetState is InternetDisconnectedState) {
        emit(Connection_State(connectionType: ConnectionType.noConnec));
        emit(ErrorState(error: "There is no Internet Connection"));
      }
    });
  }

  //get request being sent to api in-cordination to userRepository
  // GET API CALL
  void getUserFromApi() {
    try {
      _userRepository.getUsersFromApi().then((values) {
        emit(UserLoadedState(users: values));
      });
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  //DELETE API CALL
  void deleteApiCall({required UserModel userModel}) {
    try {
      _userRepository.deleteData(userModel: userModel).then((value) {
        emit(UserDeletedState(message: value));
        getUserFromApi();
      });
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  //PUT API CALL
  void putApiCall({
    required UserModel user,
    required String job,
  }) {
    try {
      _userRepository.putData(user: user, job: job).then((value) {
        emit(UserUpdatedState(message: value));
        getUserFromApi();
      });
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  //after bloc closes cancel subscription
  @override
  Future<void> close() {
    internetSubscription?.cancel();
    return super.close();
  }
}
