import 'package:bus_booking/presentation/pages/splash/bloc/splash_bloc.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashBloc>(SplashBloc());
  }
}
