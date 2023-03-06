part of 'post_api_bloc.dart';

abstract class PostApiState extends Equatable {
  const PostApiState();

  @override
  List<Object> get props => [];
}

class PostApiInitial extends PostApiState {}

class LoadingState extends PostApiState {}

//after form validation yo state emit garni
class PostApiValidState extends PostApiState {}

//after form submission response state
class PostApiResponseState extends PostApiState {
  final PostUserModel postUserModel;
  const PostApiResponseState({
    required this.postUserModel,
  });
}

class PostApiError extends PostApiState {
  final String error;
  const PostApiError({
    required this.error,
  });
}

class CheckConnectionState extends PostApiState {
  final ConnectionType connectionType;
  const CheckConnectionState({
    required this.connectionType,
  });

  @override
  List<Object> get props => [connectionType.name];
}
