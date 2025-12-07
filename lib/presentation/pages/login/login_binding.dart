import 'package:bus_booking/presentation/pages/login/bloc/login_bloc.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginBloc>(() => LoginBloc());
  }
}
