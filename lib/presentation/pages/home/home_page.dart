import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/home/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';

part 'components/app_bar_home.dart';
part 'components/thread_item.dart';
part 'components/user_post_threads.dart';
part 'components/action_button.dart';
part 'components/avatar_user.dart';
part 'components/media_content.dart';
part 'components/info_user.dart';

class HomePage extends BaseBlocPage<HomeBloc> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBarHome(context),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildPostThreads(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildThreadItem(
                      context,
                      isLinkTopic: index % 2 == 0,
                      isVerified: index % 3 == 0,
                    );
                  },
                  childCount: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
