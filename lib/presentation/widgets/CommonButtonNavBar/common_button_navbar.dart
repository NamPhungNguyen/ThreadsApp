import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonButtonNavbar extends StatelessWidget {
  const CommonButtonNavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context,
              index: 0,
              activeIconPath: AppBasePath.icon(AppIcons.home),
              inActiveIconPath: AppBasePath.icon(AppIcons.homeFilled),
            ),
            _buildNavItem(
              context: context,
              index: 1,
              activeIconPath: AppBasePath.icon(AppIcons.explore),
              inActiveIconPath: AppBasePath.icon(AppIcons.exploreFilled),
            ),
            _buildNavItem(
              context: context,
              index: 2,
              activeIconPath: AppBasePath.icon(AppIcons.write),
              inActiveIconPath: AppBasePath.icon(AppIcons.writeFilled),
            ),
            _buildNavItem(
              context: context,
              index: 3,
              activeIconPath: AppBasePath.icon(AppIcons.heart),
              inActiveIconPath: AppBasePath.icon(AppIcons.heartFilled),
            ),
            _buildNavItem(
              context: context,
              index: 4,
              activeIconPath: AppBasePath.icon(AppIcons.user),
              inActiveIconPath: AppBasePath.icon(AppIcons.userFilled),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String inActiveIconPath,
    required String activeIconPath,
  }) {
    final isActive = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: 60,
          child: Center(
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                isActive ? activeIconPath : inActiveIconPath,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
