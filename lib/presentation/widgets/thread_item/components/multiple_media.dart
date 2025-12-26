import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/full_screen_media/full_screen_media.dart';
import 'package:bus_booking/presentation/widgets/image_media/image_media.dart';
import 'package:bus_booking/presentation/widgets/video_player_media/video_player.dart';
import 'package:flutter/material.dart';

class MultipleMedia extends StatelessWidget {
  const MultipleMedia({super.key, required this.mediaUrls});

  final List<MediaEntity> mediaUrls;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Transform.translate(
      offset: const Offset(-12, 0),
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(left: 62),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemCount: mediaUrls.length,
          itemBuilder: (context, index) {
            final mediaType = mediaUrls[index].type;
            if (mediaType == MediaType.video) {
              return SizedBox(
                width: screenWidth * 0.6,
                child: VideoPlayerWidget(
                  videoUrl: mediaUrls[index].url,
                  onTap: () => _openFullScreenMedia(context, mediaUrls, index),
                ),
              );
            }
            return ImageMedia(
              key: ValueKey(mediaUrls[index]),
              imageUrl: mediaUrls[index].url,
              width: screenWidth * 0.6,
              onTap: () => _openFullScreenMedia(context, mediaUrls, index),
            );
          },
        ),
      ),
    );
  }
}

void _openFullScreenMedia(
    BuildContext context, List<MediaEntity> mediaUrls, int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => FullScreenMedia(
        mediaUrls: mediaUrls,
        initialIndex: index,
      ),
    ),
  );
}
