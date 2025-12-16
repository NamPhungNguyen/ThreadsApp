import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/home/bloc/home_bloc.dart';
import 'package:bus_booking/presentation/widgets/thread_item/thread_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

part 'components/app_bar_home.dart';
part 'components/user_new_post_threads.dart';

class HomePage extends BaseBlocPage<HomeBloc> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarHome(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildNewPostThreads(),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // todo: add api call
              final List<String> images = [];
              const content = null;
              return SliverList.builder(
                itemBuilder: (context, index) {
                  return ThreadItem(
                    content: content,
                    images: images,
                    isLinkTopic: index % 2 == 0,
                    isVerified: index % 3 == 0,
                    likeCount: 7982000 + index * 100,
                    commentCount: 12223 + index * 10,
                    repostCount: 44 + index,
                    shareCount: 11 + index * 2,
                  );
                },
                itemCount: 5,
              );
            },
          ),
        ],
      ),
    );
  }
}
