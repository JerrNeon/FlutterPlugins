import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_plugin.dart';
import 'package:xmly_example/utils/date_utils.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final xmly = Xmly();
  StreamSubscription _onPlayStartSubscription;
  StreamSubscription _onPlayPauseSubscription;
  StreamSubscription _onSoundSwitchSubscription;
  StreamSubscription _onPlayProgressSubscription;
  Track _track;
  bool _isPlaying;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _initTrack();
    _initListener();
  }

  @override
  void dispose() {
    _onPlayStartSubscription?.cancel();
    _onPlayPauseSubscription?.cancel();
    _onSoundSwitchSubscription?.cancel();
    _onPlayProgressSubscription?.cancel();
    super.dispose();
  }

  _initTrack() async {
    _track = await xmly.getCurrSound();
    _isPlaying = await xmly.isPlaying();
    if (mounted) {
      setState(() {});
    }
  }

  _initListener() async {
    _onPlayStartSubscription = xmly.onPlayStart.listen((event) {
      print("play page -> onPlayStart");
      _initTrack();
    });
    _onPlayPauseSubscription = xmly.onPlayPause.listen((event) {
      print("play page -> onPlayPause");
      _initTrack();
    });
    _onSoundSwitchSubscription = xmly.onSoundSwitch.listen((event) async {
      print("play page -> onSoundSwitch");
      _initTrack();
    });
    _onPlayProgressSubscription = xmly.onPlayProgress.listen((progress) {
      print("play page -> onPlayProgress $progress");
      _progress = progress;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6a8894),
      appBar: AppBar(
        backgroundColor: Color(0xff6a8894),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: _track != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Text(
                      _track.trackTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Image.network(
                      _track.coverUrlLarge,
                      width: 210,
                      height: 210,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Slider(
                      value: _progress,
                      onChanged: (value) {
                        _progress = value;
                      },
                      onChangeEnd: (value) {
                        xmly.seekToByPercent(percent: value);
                      },
                      inactiveColor: Colors.white30,
                      activeColor: Colors.white,
                      label:
                          "${TimeUtils.getTimeFromSecond(_track.duration * _progress)}/${TimeUtils.getTimeFromSecond(_track.duration)}",
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                          onPressed: () => xmly.playPre(),
                        ),
                        SizedBox(width: 30),
                        IconButton(
                          iconSize: 40,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (_isPlaying) {
                              await xmly.pause();
                            } else {
                              await xmly.play();
                            }
                            setState(() {
                              _isPlaying = !_isPlaying;
                            });
                          },
                        ),
                        SizedBox(width: 30),
                        IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                          onPressed: () => xmly.playNext(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            )
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
    );
  }
}
