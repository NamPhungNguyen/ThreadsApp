import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonButtonNavbar extends StatelessWidget {
  const CommonButtonNavbar({
    super.key,
    required this.onTabTap,
    required this.onNewThreadTap,
    required this.currentIndex,
  });

  final Function(int) onTabTap;
  final VoidCallback onNewThreadTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context,
              index: 0,
              activeIconPath: AppIcons.home,
              inActiveIconPath: AppIcons.homeFilled,
            ),
            _buildNavItem(
              context: context,
              index: 1,
              activeIconPath: AppIcons.explore,
              inActiveIconPath: AppIcons.exploreFilled,
            ),
            _buildNewThreadButton(context),
            _buildNavItem(
              context: context,
              index: 2,
              activeIconPath: AppIcons.heart,
              inActiveIconPath: AppIcons.heartFilled,
            ),
            _buildNavItem(
              context: context,
              index: 3,
              activeIconPath: AppIcons.user,
              inActiveIconPath: AppIcons.userFilled,
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
        onTap: () => onTabTap(index),
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

  Widget _buildNewThreadButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onNewThreadTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: SizedBox(
          height: 60,
          child: Center(
            child: AnimatedOpacity(
              opacity: 0.4,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                AppIcons.write,
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
