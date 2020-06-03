import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';
import 'package:xmly_example/utils/date_utils.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  Track _track;
  bool _isPlaying;
  double _progress = 0;
  IPlayStatusCallback _iPlayStatusCallback;

  @override
  void initState() {
    super.initState();
    _initTrack();
    _initListener();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback);
    super.dispose();
  }

  _initTrack() async {
    _track = await Xmly().getCurrSound();
    _isPlaying = await Xmly().isPlaying();
    if (mounted) {
      setState(() {});
    }
  }

  _initListener() async {
    bool isConnected = await Xmly().isConnected();
    if (isConnected) {
      _iPlayStatusCallback ??= IPlayStatusCallback();
      _iPlayStatusCallback.onPlayStart = () {
        print("xmly -> onPlayStart");
        _initTrack();
      };
      _iPlayStatusCallback.onPlayPause = () {
        print("xmly -> onPlayPause");
        _initTrack();
      };
      _iPlayStatusCallback.onBufferProgress =
          (progress) => print("xmly -> onBufferProgress $progress");
      _iPlayStatusCallback.onPlayProgress = (progress) {
        print("xmly -> onPlayProgress $progress");
        _progress = progress;
        if (mounted) {
          setState(() {});
        }
      };
      _iPlayStatusCallback.onSoundSwitch = () {
        _initTrack();
      };
      Xmly().addPlayerStatusListener(_iPlayStatusCallback);
    }
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
                        Xmly().seekToByPercent(percent: value);
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
                          onPressed: () => Xmly().playPre(),
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
                              await Xmly().pause();
                            } else {
                              await Xmly().play();
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
                          onPressed: () => Xmly().playNext(),
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
