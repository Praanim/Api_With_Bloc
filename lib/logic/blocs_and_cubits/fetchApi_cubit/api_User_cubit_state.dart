import 'package:flutter/foundation.dart';

import 'package:api_bloc/constants/enum.dart';
import 'package:api_bloc/data/models/user_models.dart';

@immutable
abstract class UserState {}

//internet connection check garni state
class Connection_State extends UserState {
  final ConnectionType connectionType;
  Connection_State({
    required this.connectionType,
  });
}

//deleteMethod huda call huney State

class UserDeletedState extends UserState {
  final Map<String, String> message;
  UserDeletedState({
    required this.message,
  });
}

//updateMethod call huda ko state

class UserUpdatedState extends UserState {
  final String message;
  UserUpdatedState({
    required this.message,
  });
}

//loading huda dekhauney state
class UserLoadingState extends UserState {}

//data loaded state
class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState({
    required this.users,
  });
}

//error huda dekhiney state
class ErrorState extends UserState {
  final String error;
  ErrorState({
    required this.error,
  });
}
