import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageMedia extends StatefulWidget {
  const ImageMedia({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.onTap,
    this.height = 200,
  });

  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  State<ImageMedia> createState() => _ImageMediaState();
}

class _ImageMediaState extends State<ImageMedia>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheWidth = (pixelRatio * widget.width).toInt();
    print("pixelRatio: $pixelRatio");
    print("cacheWidth: $cacheWidth");

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            memCacheWidth: cacheWidth,
            maxWidthDiskCache: cacheWidth,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              height: widget.height,
              color: AppColors.borderDark,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              height: widget.height,
              color: AppColors.borderDark,
              child: const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
      ),
    );
  }
}
