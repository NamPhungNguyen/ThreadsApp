import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/full_screen_media/full_screen_media.dart';
import 'package:bus_booking/presentation/widgets/image_media/image_media.dart';
import 'package:bus_booking/presentation/widgets/video_player_media/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleMedia extends StatefulWidget {
  const SingleMedia({super.key, required this.media});

  final MediaEntity media;

  @override
  State<SingleMedia> createState() => _SingleMediaState();
}

class _SingleMediaState extends State<SingleMedia> {
  VideoPlayerController? _videoController;

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width;
    print("Single Media: $imageWidth");
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 12),
      child: widget.media.type == MediaType.image
          ? _buildMediaImage(context, widget.media, imageWidth)
          : _buildMediaVideo(context, widget.media),
    );
  }

  Widget _buildMediaImage(
    BuildContext context,
    MediaEntity media,
    double width,
  ) {
    return ImageMedia(
      imageUrl: media.url,
      width: width,
      onTap: () => _openFullScreen(context, media, 0),
    );
  }

  Widget _buildMediaVideo(BuildContext context, MediaEntity media) {
    return VideoPlayerWidget(
      videoUrl: media.url,
      onTap: () => _openFullScreen(context, media, 0),
      onControllerReady: (controller) {
        _videoController = controller;
      },
    );
  }

  void _openFullScreen(BuildContext context, MediaEntity media, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) =>
            FullScreenMedia(
          media: [media],
          initialIndex: index,
          existingVideoControllers:
              _videoController != null ? {0: _videoController!} : null,
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
