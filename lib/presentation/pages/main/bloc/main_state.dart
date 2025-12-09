part of 'main_bloc.dart';

abstract class MainState {
  final int currentIndex;
  const MainState({this.currentIndex = 0});
}

class MainInitial extends MainState {
  const MainInitial() : super(currentIndex: 0);
}

class MainTabChanged extends MainState {
  const MainTabChanged({required int currentIndex})
      : super(currentIndex: currentIndex);
}
