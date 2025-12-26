import 'package:bus_booking/domain/entities/media/media_entity.dart';

class ThreadEntity {
  const ThreadEntity({
    required this.id,
    this.avatarUrl,
    this.content,
    this.media = const [],
    this.isLinkTopic = false,
    this.isVerified = false,
    this.likeCount = 0,
    this.commentCount = 0,
    this.repostCount = 0,
    this.shareCount = 0,
  });

  final String id;
  final String? avatarUrl;
  final String? content;
  final List<MediaEntity> media;
  final bool isLinkTopic;
  final bool isVerified;
  final int likeCount;
  final int commentCount;
  final int repostCount;
  final int shareCount;
}
