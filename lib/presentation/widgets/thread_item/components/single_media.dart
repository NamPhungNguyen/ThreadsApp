import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:bus_booking/presentation/widgets/video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SingleMedia extends StatelessWidget {
  const SingleMedia({super.key, required this.mediaUrls});

  final List<MediaEntity> mediaUrls;

  @override
  Widget build(BuildContext context) {
    final mediaUrl = mediaUrls.first;
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: mediaUrl.type == MediaType.image
            ? _buildMediaImage(context, mediaUrl)
            : _buildMediaVideo(context, mediaUrl),
      ),
    );
  }

  Widget _buildMediaVideo(BuildContext context, MediaEntity mediaUrl) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: VideoPlayerWidget(videoUrl: mediaUrl.url),
    );
  }

  Widget _buildMediaImage(BuildContext context, MediaEntity media) {
    return GestureDetector(
      onTap: () => showFullImage(context, mediaUrls, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: media.url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          placeholder: (context, url) => Container(
            height: 200,
            color: AppColors.borderDark,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 200,
            color: AppColors.borderDark,
            child: const Center(
              child: Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

void showFullImage(
    BuildContext context, List<MediaEntity> imageUrls, int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: PhotoViewGallery.builder(
          itemCount: imageUrls.length,
          pageController: PageController(initialPage: index),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(imageUrls[index].url),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3,
            );
          },
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    ),
  );
}
