import 'package:bus_booking/foundation/architecture/base_bloc.dart';
import 'package:bus_booking/presentation/pages/home/bloc/home_bloc.dart';
import 'package:bus_booking/presentation/widgets/CommonButtonNavBar/common_button_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends BaseBlocPage<HomeBloc> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(),
          bottomNavigationBar: CommonButtonNavbar(
            onTap: (int p1) {
              return 0;
            },
            currentIndex: 0,
          ),
        );
      },
    );
  }
}
