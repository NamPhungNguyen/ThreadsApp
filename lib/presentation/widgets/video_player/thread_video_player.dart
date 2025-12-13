import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ThreadVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;

  const ThreadVideoPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
  });

  @override
  State<ThreadVideoPlayer> createState() => _ThreadVideoPlayerState();
}

class _ThreadVideoPlayerState extends State<ThreadVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = false;
  bool _showThumbnail = true;

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    setState(() => _isLoading = true);

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController!.value.aspectRatio,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.white,
        handleColor: Colors.white,
        backgroundColor: AppColors.borderDark,
        bufferedColor: AppColors.hintText,
      ),
    );

    setState(() {
      _isLoading = false;
      _showThumbnail = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _showThumbnail
            ? _buildThumbnail()
            : _isLoading
                ? _buildLoading()
                : Chewie(controller: _chewieController!),
      ),
    );
  }

  Widget _buildThumbnail() {
    return GestureDetector(
      onTap: _initializeVideo,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          if (widget.thumbnailUrl != null)
            CachedNetworkImage(
              imageUrl: widget.thumbnailUrl!,
              fit: BoxFit.cover,
            )
          else
            Container(color: AppColors.borderDark),
          // Play button
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      color: AppColors.borderDark,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}