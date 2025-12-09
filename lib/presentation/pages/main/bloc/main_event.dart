part of 'main_bloc.dart';

abstract class MainEvent {}

class ChangeTabEvent extends MainEvent {
  final int index;
  ChangeTabEvent(this.index);
}
