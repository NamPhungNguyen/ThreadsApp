import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/new_thread/bloc/new_thread_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class NewThreadPage extends BaseBlocPage<NewThreadBloc> {
  NewThreadPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<NewThreadBloc, NewThreadState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildHeader(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => {Get.back()},
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const Text(
            "New Thread",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.home,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                AppIcons.home,
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
