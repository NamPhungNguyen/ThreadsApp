import 'package:bus_booking/presentation/pages/home/home_binding.dart';
import 'package:bus_booking/presentation/pages/main/bloc/main_bloc.dart';
import 'package:bus_booking/presentation/pages/new_thread/new_thread_binding.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBloc>(() => MainBloc());
    HomeBinding().dependencies();
    NewThreadBinding().dependencies();
  }
}
