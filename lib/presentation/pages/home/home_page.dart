import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends BaseBlocPage<HomeBloc> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: SvgPicture.asset(
              AppIcons.heart,
              width: 24,
              height: 24,
            ),
            title: SvgPicture.asset(
              AppIcons.threads,
              width: 32,
              height: 32,
            ),
            centerTitle: true,
          ),
          body: const Center(
            child: Text("Home"),
          ),
        );
      },
    );
  }
}
