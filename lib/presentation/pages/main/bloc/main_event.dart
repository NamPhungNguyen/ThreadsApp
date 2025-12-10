part of 'main_bloc.dart';

abstract class MainEvent {}

class ChangeTabEvent extends MainEvent {
  final int tabIndex;
  ChangeTabEvent(this.tabIndex);
}
