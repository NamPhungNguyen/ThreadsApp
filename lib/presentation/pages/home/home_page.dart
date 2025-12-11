import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/core/constants/app_colors.dart';
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
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                AppIcons.threads,
                colorFilter: const ColorFilter.mode(
                  AppColors.borderDark,
                  BlendMode.srcIn,
                ),
              ),
            ),
            leadingWidth: 42,
            title: SvgPicture.asset(
              AppIcons.threads,
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onPrimary,
                BlendMode.srcIn,
              ),
            ),
            centerTitle: true,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            actions: [
              SvgPicture.asset(
                AppIcons.explore,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.borderDark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildPostThreads(),
              Expanded(child: _buildThreadItem()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThreadItem() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    top: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostThreads() {
    return GestureDetector(
      onTap: () => {print("Test")},
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderDark,
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nguyen Phung Nam"),
                  SizedBox(height: 2),
                  Text(
                    "What's new?",
                    style: TextStyle(
                      color: AppColors.hintText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
