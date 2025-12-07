import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/core/routes/app_routes.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashPage extends BaseBlocPage<SplashBloc> {
  SplashPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToLogin) {
          Get.offAllNamed(Routes.LOGIN);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 150,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash_logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              if (state is SplashLoading)
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 50,
                child: InkWell(
                  onTap: () {
                    context.read<SplashBloc>().add(SplashLoginPressed());
                  },
                  child: Container(
                    width: 359,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Log in with Instagram",
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Nam Phung Nguyen",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            "assets/icons/instagram_logo.svg",
                            fit: BoxFit.contain,
                            height: 45,
                            width: 45,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
