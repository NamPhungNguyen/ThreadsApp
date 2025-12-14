part of '../home_page.dart';

extension MediaContent on HomePage {
  Widget _buildMediaContent(BuildContext context, List<String> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    if (images.length == 1) {
      return _buildSingleImage(context, images.first);
    }

    return _buildMultipleImages(context, images);
  }

  Widget _buildSingleImage(BuildContext context, String image) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 12),
      child: GestureDetector(
        onTap: () => _showFullImage(context, image),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: image,
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

  Widget _buildMultipleImages(BuildContext context, List<String> images) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Shift left by 12 (parent padding) to start at screen edge
    return Transform.translate(
      offset: const Offset(-12, 0),
      child: SizedBox(
        height: 300,
        width: screenWidth,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          // Align first item with text (12 + 50 = 62), right padding 12
          padding: const EdgeInsets.only(left: 62, right: 12),
          // Allow content to scroll into the padding area (over the avatar)
          clipBehavior: Clip.none,
          itemCount: images.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showFullImage(context, images[index]),
              child: SizedBox(
                // Each item takes 70% of screen width
                width: screenWidth * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
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
          },
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
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
          extendBodyBehindAppBar: true, // Hiển thị nội dung phía sau AppBar
          body: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
