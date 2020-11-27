import 'package:thepondapp/models/VimeoFile.dart';

class VimeoVideo {
  final String name;
  final String link;
  final List<VimeoFile> files;

  VimeoVideo({this.name, this.link, this.files});

  factory VimeoVideo.fromJson(Map<String, dynamic> json) {
    var list = json['files'] as List;
    List<VimeoFile> files = list.map((i) => VimeoFile.fromJson(i)).toList();

    return VimeoVideo(
      name: json['name'],
      link: json['link'],
      files: files,
    );
  }
}
