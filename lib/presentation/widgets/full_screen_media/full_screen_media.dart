import 'package:bus_booking/domain/entities/media/media_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class FullScreenMedia extends StatefulWidget {
  const FullScreenMedia({
    super.key,
    required this.media,
    required this.initialIndex,
    this.existingVideoControllers,
  });

  final List<MediaEntity> media;
  final int initialIndex;
  final Map<int, VideoPlayerController>? existingVideoControllers;

  @override
  State<FullScreenMedia> createState() => _FullScreenMediaState();
}

class _FullScreenMediaState extends State<FullScreenMedia> {
  late PageController _pageController;
  late int _currentIndex;
  double _dragOffset = 0;
  static const double _dismissThreshold = 100;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // Immersive mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _handleVerticalDrag(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta.dy;
      // Chỉ cho kéo xuống
      if (_dragOffset < 0) _dragOffset = 0;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragOffset > _dismissThreshold) {
      Navigator.pop(context);
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate opacity dựa trên drag offset
    final opacity = (1.0 - (_dragOffset / 300)).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: opacity),
      body: GestureDetector(
        onVerticalDragUpdate: _handleVerticalDrag,
        onVerticalDragEnd: _handleDragEnd,
        child: AnimatedContainer(
          duration: _dragOffset == 0
              ? const Duration(milliseconds: 200)
              : Duration.zero,
          transform: Matrix4.translationValues(0, _dragOffset, 0),
          child: Stack(
            children: [
              // Media PageView
              PageView.builder(
                controller: _pageController,
                physics: _dragOffset > 0
                    ? const NeverScrollableScrollPhysics()
                    : null,
                itemCount: widget.media.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final media = widget.media[index];
                  if (media.type == MediaType.image) {
                    return _ImagePage(media: media);
                  } else {
                    return _VideoPage(
                      media: media,
                      isActive: _currentIndex == index,
                      existingController:
                          widget.existingVideoControllers?[index],
                    );
                  }
                },
              ),

              // Close button
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 8,
                child: AnimatedOpacity(
                  opacity: (1.0 - (_dragOffset / 10)).clamp(0.0, 1.0),
                  duration: Duration.zero,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ),

              // Page indicator
              if (widget.media.length > 1)
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: Duration.zero,
                    opacity: (1.0 - (_dragOffset / 10)).clamp(0.0, 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.media.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full screen image with zoom
class _ImagePage extends StatelessWidget {
  const _ImagePage({required this.media});

  final MediaEntity media;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: CachedNetworkImageProvider(media.url),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 3,
      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      enableRotation: false,
    );
  }
}

/// Full screen video with controls
class _VideoPage extends StatefulWidget {
  const _VideoPage({
    required this.media,
    required this.isActive,
    this.existingController,
  });

  final MediaEntity media;
  final bool isActive;
  final VideoPlayerController? existingController;

  @override
  State<_VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<_VideoPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls = true;
  bool _isMuted = false;
  bool _isDragging = false;
  bool _ownsController = false; // Track if we created the controller

  @override
  void initState() {
    super.initState();

    // Use existing controller if provided, otherwise create new one
    if (widget.existingController != null) {
      _controller = widget.existingController!;
      _ownsController = false;
      _isInitialized = _controller.value.isInitialized;

      if (_isInitialized) {
        _controller.setLooping(true);
        if (widget.isActive) {
          _controller.play();
        }
        _startHideTimer();
      } else {
        // Controller exists but not initialized yet
        _controller.initialize().then((_) {
          if (mounted) {
            setState(() => _isInitialized = true);
            _controller.setLooping(true);
            if (widget.isActive) {
              _controller.play();
            }
            _startHideTimer();
          }
        });
      }
    } else {
      // Create new controller
      _ownsController = true;
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.media.url))
            ..initialize().then((_) {
              if (mounted) {
                setState(() => _isInitialized = true);
                _controller.setLooping(true);
                if (widget.isActive) {
                  _controller.play();
                }
                _startHideTimer();
              }
            });
    }
  }

  @override
  void didUpdateWidget(covariant _VideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Play/pause based on active state
    if (widget.isActive && !_controller.value.isPlaying && _isInitialized) {
      _controller.play();
    } else if (!widget.isActive && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    // Only dispose if we own the controller
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _startHideTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying && !_isDragging) {
        setState(() => _showControls = false);
      }
    });
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
      _startHideTimer();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _onTap() {
    setState(() => _showControls = !_showControls);
    if (_showControls) {
      _startHideTimer();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Video
          if (_isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // Controls overlay - use ValueListenableBuilder to only rebuild controls
          if (_isInitialized)
            ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: _controller,
              builder: (context, value, child) {
                return AnimatedOpacity(
                  opacity: _showControls ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: Stack(
                      children: [
                        // Center play/pause
                        Center(
                          child: GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                        ),

                        // Bottom controls
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: MediaQuery.of(context).padding.bottom + 60,
                          child: Column(
                            children: [
                              // Progress bar
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 4,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6,
                                  ),
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor:
                                      Colors.white.withValues(alpha: 0.3),
                                  thumbColor: Colors.white,
                                ),
                                child: Slider(
                                  value: value.position.inMilliseconds
                                      .toDouble()
                                      .clamp(
                                        0,
                                        value.duration.inMilliseconds
                                            .toDouble(),
                                      ),
                                  min: 0,
                                  max: value.duration.inMilliseconds.toDouble(),
                                  onChangeStart: (_) => _isDragging = true,
                                  onChanged: (v) {
                                    _controller.seekTo(
                                        Duration(milliseconds: v.toInt()));
                                  },
                                  onChangeEnd: (_) {
                                    _isDragging = false;
                                    _startHideTimer();
                                  },
                                ),
                              ),

                              // Time and mute
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _toggleMute,
                                      child: Icon(
                                        _isMuted
                                            ? Icons.volume_off_rounded
                                            : Icons.volume_up_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
