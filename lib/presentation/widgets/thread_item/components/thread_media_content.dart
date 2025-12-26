import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/single_media.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/multiple_media.dart';
import 'package:flutter/material.dart';

class ThreadMediaContent extends StatelessWidget {
  const ThreadMediaContent({
    super.key,
    required this.mediaUrls,
  });

  final List<MediaEntity> mediaUrls;

  @override
  Widget build(BuildContext context) {
    if (mediaUrls.isEmpty) return const SizedBox.shrink();

    if (mediaUrls.length == 1) {
      return SingleMedia(mediaUrl: mediaUrls.first);
    }

    return MultipleMedia(mediaUrls: mediaUrls);
  }
}
