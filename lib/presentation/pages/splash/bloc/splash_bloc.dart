import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitialEvent>(_onInitial);
    on<SplashLoginPressed>(_onLoginPressed);
  }

  Future<void> _onInitial(
    SplashInitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> _onLoginPressed(
    SplashLoginPressed event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    emit(SplashNavigateToLogin());
  }
}
