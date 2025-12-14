part of '../home_page.dart';

extension ActionButton on HomePage {
  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildActionButton(AppIcons.heartPost, "2K"),
        _buildActionButton(AppIcons.message, "123"),
        _buildActionButton(AppIcons.repost, "44"),
        _buildActionButton(AppIcons.send, "11"),
      ],
    );
  }

  Widget _buildActionButton(String icon, String count) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => print("Action: $icon"),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                AppColors.hintText,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(color: AppColors.hintText),
            ),
          ],
        ),
      ),
    );
  }
}
