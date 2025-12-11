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
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // avatar user
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
                    ),
                  ),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: Container(
                      height: 26,
                      width: 26,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                      ),
                      child: SvgPicture.asset(
                        AppIcons.cross,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // new post user
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // info user
                      Row(
                        children: [
                          const Text("studywithnam"),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            AppIcons.verified,
                            height: 14,
                            width: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "21h",
                            style: TextStyle(
                              color: AppColors.borderDark,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            AppIcons.dots,
                            colorFilter: const ColorFilter.mode(
                              AppColors.hintText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '''This is a long post content. 
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                       Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. 
                       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content.
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit a
                        met, consectetur adipiscing elit.
                         Sed do eiusmod tempor incididunt u
                         t labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit amet, consectetur 
                         adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                         Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                         This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. 
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is 
                         a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
                          incididunt ut labore et dolore magna aliqua.This is a long post content. Lo
                         rem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna 
                         aliqua.This is a long post content. 
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                         This is a long post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.This is a long post content. 
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                      Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.''',
                        maxLines: 20,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.heartPost,
                            colorFilter: ColorFilter.mode(
                                AppColors.hintText, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "2K",
                            style: TextStyle(color: AppColors.hintText),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            AppIcons.message,
                            colorFilter: ColorFilter.mode(
                                AppColors.hintText, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "123",
                            style: TextStyle(color: AppColors.hintText),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            AppIcons.repost,
                            colorFilter: ColorFilter.mode(
                                AppColors.hintText, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "44",
                            style: TextStyle(color: AppColors.hintText),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            AppIcons.send,
                            colorFilter: ColorFilter.mode(
                                AppColors.hintText, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "11",
                            style: TextStyle(color: AppColors.hintText),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
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
              radius: 25,
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
