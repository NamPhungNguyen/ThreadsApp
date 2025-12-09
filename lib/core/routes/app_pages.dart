import 'package:bus_booking/core/routes/app_routes.dart';
import 'package:bus_booking/presentation/pages/login/login_binding.dart';
import 'package:bus_booking/presentation/pages/login/login_page.dart';
import 'package:bus_booking/presentation/pages/main/main_binding.dart';
import 'package:bus_booking/presentation/pages/main/main_page.dart';
import 'package:bus_booking/presentation/pages/splash/splash_binding.dart';
import 'package:bus_booking/presentation/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
      binding: MainBinding(),
    )
  ];
}
