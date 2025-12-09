import 'package:bus_booking/presentation/pages/new_thread/bloc/new_thread_bloc.dart';
import 'package:get/get.dart';

class NewThreadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewThreadBloc>(() => NewThreadBloc());
  }
}
