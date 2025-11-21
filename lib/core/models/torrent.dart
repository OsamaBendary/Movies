class Torrent {
  final String url;
  final String quality;
  final String type;
  final String size;
  final int sizeBytes;

  Torrent({
    required this.url,
    required this.quality,
    required this.type,
    required this.size,
    required this.sizeBytes,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'] as String,
      quality: json['quality'] as String,
      type: json['type'] as String,
      size: json['size'] as String,
      sizeBytes: json['size_bytes'] as int,
    );
  }
}