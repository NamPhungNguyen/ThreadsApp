import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/single_media.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/multiple_media.dart';
import 'package:flutter/material.dart';

class ThreadMediaContent extends StatelessWidget {
  const ThreadMediaContent({
    super.key,
    required this.media,
  });

  final List<MediaEntity> media;

  @override
  Widget build(BuildContext context) {
    if (media.isEmpty) return const SizedBox.shrink();

    if (media.length == 1) {
      return SizedBox(
        height: 200,
        child: SingleMedia(media: media.first),
      );
    }

    return MultipleMedia(media: media);
  }
}
