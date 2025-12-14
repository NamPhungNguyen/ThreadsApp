part of '../home_page.dart';

extension AvatarUser on HomePage {
  Widget _buildAvatarUser(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Avatar user"),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
            ),
          ),
          Positioned(
            bottom: -4,
            right: -4,
            child: GestureDetector(
              onTap: () => print("Follow"),
              child: Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: SvgPicture.asset(
                  AppIcons.cross,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
