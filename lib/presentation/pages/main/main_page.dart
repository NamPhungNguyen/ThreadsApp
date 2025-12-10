import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/activity/activity_page.dart';
import 'package:bus_booking/presentation/pages/home/home_page.dart';
import 'package:bus_booking/presentation/pages/main/bloc/main_bloc.dart';
import 'package:bus_booking/presentation/pages/new_thread/new_thread_page.dart';
import 'package:bus_booking/presentation/pages/profile/profile_page.dart';
import 'package:bus_booking/presentation/pages/search/search_page.dart';
import 'package:bus_booking/presentation/widgets/common_button_nav_bar/common_button_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends BaseBlocPage<MainBloc> {
  MainPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              HomePage(),
              const SearchPage(),
              const ActivityPage(),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: CommonButtonNavbar(
            onTabTap: (index) {
              context.read<MainBloc>().add(
                    ChangeTabEvent(index),
                  );
            },
            onNewThreadTap: () => _showNewThreadModal(context),
            currentIndex: state.currentIndex,
          ),
        );
      },
    );
  }
}

void _showNewThreadModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.borderDark.withValues(alpha: 0.85),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.95, // 95% màn hình
      minChildSize: 0.5, // Kéo xuống tối thiểu 50%
      maxChildSize: 0.95, // Kéo lên tối đa 95%
      builder: (context, scrollController) => NewThreadPage(),
    ),
  );
}
