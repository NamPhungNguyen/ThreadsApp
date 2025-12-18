enum MediaType { image, video }

class MediaEntity {
  final String url;
  final MediaType type;
  final String? thumbnailUrl;

  MediaEntity({
    required this.url,
    required this.type,
    this.thumbnailUrl,
  });
}
