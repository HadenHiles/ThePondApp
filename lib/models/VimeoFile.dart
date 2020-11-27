class VimeoFile {
  final String quality;
  final String type;
  final int width;
  final int height;
  final String link;

  VimeoFile({
    this.quality,
    this.type,
    this.width,
    this.height,
    this.link,
  });

  factory VimeoFile.fromJson(Map<String, dynamic> json) {
    return VimeoFile(
      quality: json['quality'],
      type: json['type'],
      width: json['width'],
      height: json['height'],
      link: json['link'],
    );
  }
}
