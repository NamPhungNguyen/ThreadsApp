import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/full_screen_media/full_screen_media.dart';
import 'package:bus_booking/presentation/widgets/image_media/image_media.dart';
import 'package:bus_booking/presentation/widgets/video_player_media/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MultipleMedia extends StatefulWidget {
  const MultipleMedia({super.key, required this.media});

  final List<MediaEntity> media;

  @override
  State<MultipleMedia> createState() => _MultipleMediaState();
}

class _MultipleMediaState extends State<MultipleMedia> {
  final Map<int, VideoPlayerController> _videoControllers = {};

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
          // Preload 1 item ahead for smoother scrolling
          cacheExtent: screenWidth * 0.6 + 8,
          // Don't keep video states alive when scrolled out
          addAutomaticKeepAlives: false,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemCount: widget.media.length,
          itemBuilder: (context, index) {
            final mediaType = widget.media[index].type;
            if (mediaType == MediaType.video) {
              return SizedBox(
                width: screenWidth * 0.6,
                child: VideoPlayerWidget(
                  videoUrl: widget.media[index].url,
                  onTap: () => _openFullScreenMedia(context, widget.media, index),
                  onControllerReady: (controller) {
                    _videoControllers[index] = controller;
                  },
                ),
              );
            }
            return ImageMedia(
              key: ValueKey(widget.media[index]),
              imageUrl: widget.media[index].url,
              width: screenWidth * 0.6,
              onTap: () => _openFullScreenMedia(context, widget.media, index),
            );
          },
        ),
      ),
    );
  }

  void _openFullScreenMedia(
      BuildContext context, List<MediaEntity> media, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) => FullScreenMedia(
          media: media,
          initialIndex: index,
          existingVideoControllers: _videoControllers.isNotEmpty
              ? _videoControllers
              : null,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}
