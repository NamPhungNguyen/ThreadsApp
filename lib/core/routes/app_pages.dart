import 'package:bus_booking/core/routes/app_routes.dart';
import 'package:bus_booking/presentation/pages/home/home_binding.dart';
import 'package:bus_booking/presentation/pages/home/home_page.dart';
import 'package:bus_booking/presentation/pages/login/login_binding.dart';
import 'package:bus_booking/presentation/pages/login/login_page.dart';
import 'package:bus_booking/presentation/pages/splash/splash_binding.dart';
import 'package:bus_booking/presentation/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
