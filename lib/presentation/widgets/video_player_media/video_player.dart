import 'dart:async';

import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/presentation/widgets/video_player_media/video_playback_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.onTap,
    this.height = 200,
  });

  final String videoUrl;
  final double height;
  final VoidCallback? onTap;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  final Key _uniqueKey = UniqueKey();
  bool _isMuted = true;
  bool _isRegistered = false;
  double _lastVisibleFraction = -1; // -1 means not yet measured
  bool _isUserPaused = false; // Track if user manually paused
  Timer? _hideControlsTimer;
  bool _isInitialized = false;

  VideoPlaybackManager get _manager => VideoPlaybackManager.instance;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        if (mounted) {
          _controller.setVolume(0);
          _controller.setLooping(true);
          _isInitialized = true;
          setState(() {});

          // Only register if we already have visibility data
          // Otherwise wait for VisibilityDetector callback
          if (_lastVisibleFraction >= 0) {
            _registerWithManager();
          }
        }
      }).catchError((e) {
        debugPrint('❌ Video init error: $e');
      });
  }

  void _registerWithManager() {
    if (_isRegistered || !_isInitialized) return;
    _manager.registerVideo(_uniqueKey, _controller,
        initialVisibility: _lastVisibleFraction > 0 ? _lastVisibleFraction : 0);
    _isRegistered = true;
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    if (_isRegistered) {
      _manager.unregisterVideo(_uniqueKey);
    }
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _onTapVideo() {
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _uniqueKey,
      onVisibilityChanged: (VisibilityInfo info) {
        final newVisibility = info.visibleFraction;
        _lastVisibleFraction = newVisibility;

        // If initialized but not registered yet, register now with real visibility
        if (_isInitialized && !_isRegistered) {
          _registerWithManager();
        }

        if (!_controller.value.isInitialized || !_isRegistered) return;

        // Reset user pause state when scrolled out of view (< 50%)
        // So when user scrolls back, video can auto-play again
        if (newVisibility < 0.5) {
          _isUserPaused = false;
        }

        // Always update visibility to manager (let manager decide who plays)
        // Only skip if user manually paused AND video is still visible
        if (!(_isUserPaused && newVisibility > 0.5)) {
          _manager.updateVisibility(_uniqueKey, newVisibility);
        }
        // No need to call setState here - _onVideoUpdate listener handles UI updates
      },
      child: SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: _controller.value.isInitialized ? _onTapVideo : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Video Player
                if (_controller.value.isInitialized)
                  SizedBox.expand(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                else
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),

                // Mute button (Threads style - bottom right)
                if (_controller.value.isInitialized)
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: GestureDetector(
                      onTap: _toggleMute,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.borderDark,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isMuted
                              ? Icons.volume_off_rounded
                              : Icons.volume_up_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
