import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.onTap,
  });

  final String videoUrl;
  final VoidCallback? onTap;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = true;
  bool _isPlaying = false; // ✅ Changed to false - video chưa play ban đầu

  @override
  void initState() {
    super.initState();
    debugPrint('🎬 VideoPlayerWidget initState: ${widget.videoUrl}');

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        if (mounted) {
          debugPrint('✅ Video initialized successfully');
          _controller.setVolume(0);
          _controller.setLooping(true);
          setState(() {});
          // _controller.play();
        }
        // });
      }).catchError((e) {
        debugPrint('❌ Video init error: $e');
      });

    debugPrint("videoUrl: ${widget.videoUrl}");
  }

  @override
  void dispose() {
    debugPrint('🗑️ VideoPlayerWidget dispose');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        '🏗️ VideoPlayerWidget build - isInitialized: ${_controller.value.isInitialized}');

    return VisibilityDetector(
      key: ObjectKey(this), // ✅ Changed from Key to ObjectKey
      onVisibilityChanged: (VisibilityInfo info) {
        debugPrint(
            '🔔 onVisibilityChanged CALLED!'); // ✅ First thing to verify callback runs
        if (!_controller.value.isInitialized) return;

        var visiblePercentage = info.visibleFraction * 100;
        debugPrint(
            '📹 Video visibility: ${visiblePercentage.toStringAsFixed(1)}% | isPlaying: $_isPlaying');

        if (visiblePercentage > 20 && !_isPlaying) {
          // ✅ Giảm từ 60% → 20%
          debugPrint('▶️ Starting video playback');
          _controller.play();
          setState(() {
            _isPlaying = true;
          });
        } else if (visiblePercentage <= 20 && _isPlaying) {
          debugPrint('⏸️ Pausing video');
          _controller.pause();
          setState(() {
            _isPlaying = false;
          });
        }
      },
      child: GestureDetector(
        child: Stack(
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            else
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.border,
                ),
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            if (_controller.value.isInitialized)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isMuted = !_isMuted;
                    _controller.setVolume(_isMuted ? 0 : 1);
                  });
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.all(8),
                  child: _isMuted
                      ? const Icon(
                          Icons.volume_off_rounded,
                          color: AppColors.primaryDart,
                        )
                      : const Icon(
                          Icons.volume_up_rounded,
                          color: AppColors.primaryDart,
                        ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
