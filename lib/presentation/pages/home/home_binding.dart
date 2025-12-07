import 'package:bus_booking/presentation/pages/home/bloc/home_bloc.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeBloc>(HomeBloc());
  }
}
