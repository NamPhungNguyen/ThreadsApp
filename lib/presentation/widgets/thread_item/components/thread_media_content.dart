import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ThreadMediaContent extends StatelessWidget {
  const ThreadMediaContent({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    if (images.length == 1) {
      return _SingleImage(images: images);
    }

    return _MultipleImages(images: images);
  }
}

class _SingleImage extends StatelessWidget {
  const _SingleImage({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 12),
      child: GestureDetector(
        onTap: () => showFullImage(context, images, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: images.first,
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
      ),
    );
  }
}

class _MultipleImages extends StatelessWidget {
  const _MultipleImages({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Transform.translate(
      offset: const Offset(-12, 0),
      child: SizedBox(
        height: 300,
        width: screenWidth,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 62, right: 12),
          clipBehavior: Clip.none,
          itemCount: images.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return _ImageItem(
              key: ValueKey(images[index]), // Preserve widget identity
              imageUrl: images[index],
              width: screenWidth * 0.7,
              onTap: () => showFullImage(context, images, index),
            );
          },
        ),
      ),
    );
  }
}

class _ImageItem extends StatefulWidget {
  const _ImageItem({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.onTap,
  });

  final String imageUrl;
  final double width;
  final VoidCallback onTap;

  @override
  State<_ImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<_ImageItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            memCacheWidth:
                (widget.width * 2).toInt(), // 2x for better quality on high DPI
            memCacheHeight: 600, // 2x of container height
            placeholder: (context, url) => Container(
              color: AppColors.borderDark,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.borderDark,
              child: const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
      ),
    );
  }
}

void showFullImage(BuildContext context, List<String> imageUrls, int index) {
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
              imageProvider: CachedNetworkImageProvider(imageUrls[index]),
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
