import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreadAvatar extends StatelessWidget {
  const ThreadAvatar({
    super.key,
    this.avatarUrl,
    this.onTap,
    this.onFollowTap,
  });

  final String? avatarUrl;
  final VoidCallback? onTap;
  final VoidCallback? onFollowTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => print("Avatar user"),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: avatarUrl != null
                ? CachedNetworkImageProvider(
                    avatarUrl!,
                  )
                : AssetImage(AppImages.avatarDefault),
          ),
          Positioned(
            bottom: -4,
            right: -4,
            child: GestureDetector(
              onTap: onFollowTap ?? () => print("Follow"),
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
