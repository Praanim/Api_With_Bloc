import 'dart:async';

import 'package:api_bloc/constants/enum.dart';
import 'package:api_bloc/data/models/post_user_model.dart';
import 'package:api_bloc/logic/blocs_and_cubits/internet_cubit/internetState_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:api_bloc/data/repository/user_repository.dart';

import '../internet_cubit/internet_cubit.dart';

part 'post_api_event.dart';
part 'post_api_state.dart';

class PostApiBloc extends Bloc<PostApiEvent, PostApiState> {
  final UserRepository userRepository;
  final InternetCubit _internetCubit;
  StreamSubscription? internetSubscription;
  PostApiBloc(this.userRepository, this._internetCubit)
      : super(PostApiInitial()) {
    monitorInternetConnection();

    //continously checking internet connection
    on<CheckConnectionEvent>(
      (event, emit) {
        emit(CheckConnectionState(connectionType: event.connectionType));
      },
    );

    //for form validation
    on<TextFieldChangedEvent>((event, emit) {
      if (event.nameValue.isEmpty || event.jobValue.isEmpty) {
        emit(const PostApiError(error: "Please add required field"));
      } else {
        emit(PostApiValidState());
      }
    });

    //after post req is sent
    on<TextFieldSubmittedEvent>(
      (event, emit) async {
        try {
          emit(LoadingState());
          final postModel =
              await userRepository.postData(name: event.name, job: event.job);
          emit(PostApiResponseState(postUserModel: postModel));
        } catch (e) {
          emit(PostApiError(error: e.toString()));
        }
      },
    );
  }

  void monitorInternetConnection() {
    internetSubscription = _internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected) {
        add(CheckConnectionEvent(connectionType: internetState.connectionType));
      } else if (internetState is InternetDisconnectedState) {
        add(const CheckConnectionEvent(
            connectionType: ConnectionType.noConnec));
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription?.cancel();
    return super.close();
  }
}
