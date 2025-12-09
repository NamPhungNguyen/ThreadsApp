part of 'new_thread_bloc.dart';

abstract class NewThreadEvent {}

class TextChangedEvent extends NewThreadEvent {
  final String text;

  TextChangedEvent(this.text);
}
