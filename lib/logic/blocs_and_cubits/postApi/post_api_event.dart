part of 'post_api_bloc.dart';

abstract class PostApiEvent extends Equatable {
  const PostApiEvent();

  @override
  List<Object> get props => [];
}
//check connectionStatus in postUserScreen

class CheckConnectionEvent extends PostApiEvent {
  final ConnectionType connectionType;
  const CheckConnectionEvent({
    required this.connectionType,
  });
}

//form validation ko lagi
class TextFieldChangedEvent extends PostApiEvent {
  final String nameValue;
  final String jobValue;
  const TextFieldChangedEvent({
    required this.nameValue,
    required this.jobValue,
  });
}

//submission ko lagi
class TextFieldSubmittedEvent extends PostApiEvent {
  final String name;
  final String job;
  const TextFieldSubmittedEvent({
    required this.name,
    required this.job,
  });
}
