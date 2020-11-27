import 'package:flutter/material.dart';
import 'package:thepondapp/services/vimeo.dart';
import 'package:videos_player/model/video.model.dart';
import 'package:videos_player/util/theme.util.dart';
import 'package:videos_player/videos_player.dart';

class SkillsVault extends StatefulWidget {
  SkillsVault({Key key}) : super(key: key);

  @override
  _SkillsVaultState createState() => _SkillsVaultState();
}

class _SkillsVaultState extends State<SkillsVault> {
  List<NetworkVideo> videos = [];

  @override
  void initState() {
    getVideoUrl("473605460").then((url) {
      var video = NetworkVideo(id: "1", name: "Backhand To Forehand", videoUrl: url);
      var vids = videos;
      vids.add(video);

      setState(() {
        videos = vids;
      });
    });

    var video = NetworkVideo(id: "1", name: "Backhand To Forehand", videoUrl: "https://player.vimeo.com/external/473605460.hd.mp4?s=6c449bcab98efa564f4e421599e73f1dfa6a3e1a&profile_id=175");
    var vids = videos;
    vids.add(video);

    setState(() {
      videos = vids;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          VideosPlayer(
            networkVideos: videos,
            playlistStyle: Style.Style2,
          ),
        ],
      ),
    );
  }
}
