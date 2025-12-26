import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/full_screen_media/full_screen_media.dart';
import 'package:bus_booking/presentation/widgets/image_media/image_media.dart';
import 'package:bus_booking/presentation/widgets/video_player_media/video_player.dart';
import 'package:flutter/material.dart';

class SingleMedia extends StatelessWidget {
  const SingleMedia({super.key, required this.mediaUrl});

  final MediaEntity mediaUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 12),
      child: mediaUrl.type == MediaType.image
          ? _buildMediaImage(context, mediaUrl)
          : _buildMediaVideo(context, mediaUrl),
    );
  }

  Widget _buildMediaImage(BuildContext context, MediaEntity media) {
    final imageWidth = MediaQuery.of(context).size.width;
    return ImageMedia(
      imageUrl: media.url,
      width: imageWidth,
      onTap: () => _openFullScreen(context, 0),
    );
  }

  Widget _buildMediaVideo(BuildContext context, MediaEntity mediaUrl) {
    return VideoPlayerWidget(
      videoUrl: mediaUrl.url,
      onTap: () => _openFullScreen(context, 0),
    );
  }

  void _openFullScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenMedia(
          mediaUrls: [mediaUrl],
          initialIndex: index,
        ),
      ),
    );
  }
}
