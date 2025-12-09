import 'package:bus_booking/presentation/pages/main/bloc/main_bloc.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBloc>(() => MainBloc());
  }
}
