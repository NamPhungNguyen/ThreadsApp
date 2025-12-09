import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/activity/activity_page.dart';
import 'package:bus_booking/presentation/pages/home/home_page.dart';
import 'package:bus_booking/presentation/pages/main/bloc/main_bloc.dart';
import 'package:bus_booking/presentation/pages/new_thread/new_thread_page.dart';
import 'package:bus_booking/presentation/pages/profile/profile_page.dart';
import 'package:bus_booking/presentation/pages/search/search_page.dart';
import 'package:bus_booking/presentation/widgets/CommonButtonNavBar/common_button_navbar.dart';
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
            onTap: (index) {
              if (index == 2) {
                _showNewThreadModal(context);
              } else {
                context.read<MainBloc>().add(ChangeTabEvent(index));
              }
            },
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
    isScrollControlled: true, // Cho phép control height
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.95, // 95% màn hình
      minChildSize: 0.5, // Kéo xuống tối thiểu 50%
      maxChildSize: 0.95, // Kéo lên tối đa 95%
      builder: (context, scrollController) => NewThreadPage(),
    ),
  );
}
