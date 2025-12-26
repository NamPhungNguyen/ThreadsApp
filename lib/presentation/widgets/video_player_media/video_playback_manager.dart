import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

/// Global manager to ensure only ONE video plays at a time (Threads-style)
/// - Center video gets priority
/// - Smooth transitions between videos
/// - Respects user pause state
class VideoPlaybackManager {
  VideoPlaybackManager._();
  static final VideoPlaybackManager instance = VideoPlaybackManager._();

  // Map of registered videos: key -> entry
  final Map<Key, _VideoEntry> _videos = {};

  // Currently playing video key
  Key? _currentlyPlayingKey;

  // Debounce to prevent rapid switching
  DateTime? _lastSwitch;
  static const _switchDebounce = Duration(milliseconds: 150);

  /// Register a video with its visibility
  void registerVideo(Key key, VideoPlayerController controller,
      {double initialVisibility = 0}) {
    _videos[key] = _VideoEntry(
      controller: controller,
      visibleFraction: initialVisibility,
    );

    // If this is the first video with good visibility, play immediately
    if (_currentlyPlayingKey == null && initialVisibility > 0.5) {
      _currentlyPlayingKey = key;
      controller.play();
    } else {
      _updatePlayback();
    }
  }

  /// Unregister a video when disposed
  void unregisterVideo(Key key) {
    _videos.remove(key);
    if (_currentlyPlayingKey == key) {
      _currentlyPlayingKey = null;
    }
    _updatePlayback();
  }

  /// Update visibility of a video
  void updateVisibility(Key key, double visibleFraction) {
    if (!_videos.containsKey(key)) return;

    _videos[key]!.visibleFraction = visibleFraction;
    _updatePlayback();
  }

  /// Determine which video should play (highest visibility wins)
  void _updatePlayback() {
    if (_videos.isEmpty) return;

    // Debounce rapid changes
    final now = DateTime.now();
    if (_lastSwitch != null && now.difference(_lastSwitch!) < _switchDebounce) {
      return;
    }

    // Find video with highest visibility (must be > 50% to play)
    Key? bestKey;
    double bestVisibility = 0.5; // Minimum threshold

    for (final entry in _videos.entries) {
      final fraction = entry.value.visibleFraction;
      if (fraction > bestVisibility &&
          entry.value.controller.value.isInitialized) {
        bestVisibility = fraction;
        bestKey = entry.key;
      }
    }

    // If winner changed, update playback
    if (bestKey != _currentlyPlayingKey) {
      _lastSwitch = now;

      // Pause old winner
      if (_currentlyPlayingKey != null &&
          _videos.containsKey(_currentlyPlayingKey)) {
        final oldController = _videos[_currentlyPlayingKey]!.controller;
        if (oldController.value.isPlaying) {
          oldController.pause();
        }
      }

      // Play new winner
      if (bestKey != null) {
        final newController = _videos[bestKey]!.controller;
        if (!newController.value.isPlaying) {
          newController.play();
        }
      }

      _currentlyPlayingKey = bestKey;
    }
  }

  /// Check if a specific video is the currently playing one
  bool isPlaying(Key key) {
    return _currentlyPlayingKey == key;
  }

  /// Pause all videos (e.g., when app goes to background)
  void pauseAll() {
    for (final entry in _videos.values) {
      if (entry.controller.value.isPlaying) {
        entry.controller.pause();
      }
    }
    _currentlyPlayingKey = null;
  }

  /// Resume playback (e.g., when app returns to foreground)
  void resumePlayback() {
    _updatePlayback();
  }

  /// Get current playing video key (for external checks)
  Key? get currentlyPlayingKey => _currentlyPlayingKey;
}

class _VideoEntry {
  final VideoPlayerController controller;
  double visibleFraction;

  _VideoEntry({required this.controller, required this.visibleFraction});
}
