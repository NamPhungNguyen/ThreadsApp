part of '../home_page.dart';

extension AppBarHome on HomePage {
  AppBar _buildAppBarHome(BuildContext context) {
    return AppBar(
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
    );
  }
}
