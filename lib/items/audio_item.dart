import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

abstract class ListItem {

  String getTitle();

  int getFrom();

  int getTo();
}

class AudioItem implements ListItem {
  final String title;
  final int start;
  final int end;

  AudioItem(this.title, this.start, this.end);

  @override
  String getTitle() => title;

  @override
  int getFrom() => start;

  @override
  int getTo() => end;
}

class AudioItemWidget extends StatefulWidget {
  final String title;
  final int from, to;

  const AudioItemWidget({super.key, required this.title, required this.from, required this.to});

  @override
  State<AudioItemWidget> createState() => _AudioItemWidgetState();
}

class _AudioItemWidgetState extends State<AudioItemWidget> {

  bool activated = false;

  Duration _position = const Duration();

  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onAudioPositionChanged.listen((Duration duration) {
      _position = duration;
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  void playOrStop() async {
    if (activated) {
      advancedPlayer.pause();
      setState(() => activated = false);
    } else {
      audioCache.play("sound.mp3");
      seekToSecond(widget.from);
      setState(() => activated = true);
      await Future.delayed(Duration(seconds: widget.to - widget.from));
      if (activated) advancedPlayer.stop();
      setState(() => activated = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: activated ? Colors.green : const Color(0xFF1c1c1c),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
          ),
          IconButton(
            icon: Icon(
              activated ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              playOrStop();
            },
          ),
        ],
      ),
    );
  }
}
