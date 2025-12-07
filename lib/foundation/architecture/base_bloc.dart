import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class BaseBlocPage<T extends BlocBase> extends StatelessWidget {
  BaseBlocPage({super.key}) : blocPage = Get.find<T>();
  final T blocPage;

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: blocPage,
      child: buildPage(context),
    );
  }
}
