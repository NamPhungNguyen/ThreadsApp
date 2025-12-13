part of '../home_page.dart';

extension ThreadItem on HomePage {
  Widget _buildThreadItem(
    BuildContext context, {
    bool isLinkTopic = false,
    bool isVerified = false,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarUser(context),
          const SizedBox(width: 10),
          _buildPostContent(
            context,
            isLinkTopic: isLinkTopic,
            isVerified: isVerified,
            videoUrl: "https://youtu.be/xF3xSba4Juc",
            videoThumbnail: "https://img.youtube.com/vi/xF3xSba4Juc/0.jpg",
            images: [
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
            ],
            content:
                "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. With Flutter, developers can create visually appealing and high-performance apps that run seamlessly across multiple platforms. The framework offers a rich set of pre-designed widgets, a reactive programming model, and a hot-reload feature that allows for rapid development and iteration. Flutter's growing ecosystem and strong community support make it an excellent choice for developers looking to build cross-platform applications efficiently.",
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarUser(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Avatar user"),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://i.pinimg.com/736x/e9/e0/7d/e9e07de22e3ef161bf92d1bcf241e4d0.jpg',
            ),
          ),
          Positioned(
            bottom: -4,
            right: -4,
            child: GestureDetector(
              onTap: () => print("Follow"),
              child: Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: SvgPicture.asset(
                  AppIcons.cross,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(
    BuildContext context, {
    bool isLinkTopic = false,
    bool isVerified = false,
    String? content,
    List<String> images = const [],
    String? videoThumbnail,
    String? videoUrl,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoUser(context,
              isLinkTopic: isLinkTopic, isVerified: isVerified),
          const SizedBox(height: 4),
          if (content != null && content.isNotEmpty)
            Text(
              content,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          if (images.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildMediaContent(context, images),
          ],
          if (videoUrl != null)
            ThreadVideoPlayer(videoUrl: videoUrl, thumbnailUrl: videoThumbnail),
          const SizedBox(height: 12),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildMediaContent(BuildContext context, List<String> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    if (images.length == 1) {
      return GestureDetector(
        onTap: () => _showFullImage(context, images.first),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: images.first,
            fit: BoxFit.cover,
            width: double.infinity,
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
    return SizedBox(
      height: 200,
      child: PageView.builder(
          controller: PageController(
              viewportFraction: 0.85), // Hiển thị một phần của các mục bên cạnh
          itemCount: images.length,
          pageSnapping: false, // Cho phép cuộn mượt mà
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => _showFullImage(context, images[index]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover, // Bao phủ toàn bộ không gian của mục
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
          }),
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

  Widget _buildInfoUser(
    BuildContext context, {
    bool isLinkTopic = false,
    bool isVerified = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              // Username + Verified + Topic
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: "chillWithMe"),
                      // Verified ngay sau username
                      if (isVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              AppIcons.verified,
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),
                      // Topic sau verified
                      if (isLinkTopic) ...[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(
                              AppIcons.arrowRight,
                              height: 14,
                              width: 14,
                              colorFilter: const ColorFilter.mode(
                                AppColors.hintText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: "Flutter Dev"),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Time
              const Text(
                "21h",
                style: TextStyle(color: AppColors.hintText),
              ),
            ],
          ),
        ),
        // Menu dots
        GestureDetector(
          onTap: () => print("Menu"),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              AppIcons.dots,
              colorFilter: const ColorFilter.mode(
                AppColors.hintText,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildActionButton(AppIcons.heartPost, "2K"),
        _buildActionButton(AppIcons.message, "123"),
        _buildActionButton(AppIcons.repost, "44"),
        _buildActionButton(AppIcons.send, "11"),
      ],
    );
  }

  Widget _buildActionButton(String icon, String count) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => print("Action: $icon"),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                AppColors.hintText,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(color: AppColors.hintText),
            ),
          ],
        ),
      ),
    );
  }
}
