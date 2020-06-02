import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';
import 'package:xmly_example/api_manager.dart';
import 'package:xmly_example/models/index.dart';

class AlbumDetailPage extends StatefulWidget {
  final int albumId;

  const AlbumDetailPage({Key key, this.albumId}) : super(key: key);

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState(albumId);
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  final int albumId;
  int _currPlayTrackId = 0;
  Future<AlbumPageList> _albumFuture;
  Future<TrackPageList> _trackFuture;
  IConnectCallback _iConnectCallback;
  IPlayStatusCallback _iPlayStatusCallback;

  _AlbumDetailPageState(this.albumId);

  @override
  void initState() {
    super.initState();
    _initAlbumFuture();
    _initTrackFuture();
    _initListener();
    _getCurrPlayTrackId();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback);
    super.dispose();
  }

  _initAlbumFuture() {
    _albumFuture = ApiManager().getSearchAlbumList(id: albumId);
  }

  _initTrackFuture() {
    _trackFuture = ApiManager().getTracks(albumId: albumId);
  }

  _initListener() {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onPlayStart = () => print("xmly -> onPlayStart");
    _iPlayStatusCallback.onPlayPause = () => print("xmly -> onPlayPause");
    _iPlayStatusCallback.onBufferProgress =
        (progress) => print("xmly -> onBufferProgress $progress");
    _iPlayStatusCallback.onPlayProgress =
        (progress) => print("xmly -> onPlayProgress $progress");
    _iPlayStatusCallback.onSoundSwitch =
        () => _getCurrPlayTrackId(isInit: false);
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
  }

  _getCurrPlayTrackId({bool isInit = true}) async {
    Track track = await Xmly().getCurrSound();
    if (track != null) {
      _currPlayTrackId = track.id;
      if (!isInit && mounted) {
        setState(() {});
      }
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
      body: FutureBuilder<AlbumPageList>(
        future: _albumFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    _initAlbumFuture();
                    setState(() {});
                  },
                  child: Text("load failure,click retry"),
                ),
              );
            } else {
              AlbumPageList pageList = snapshot.data;
              List<Album> list = pageList.albums;
              if (list.isNotEmpty) {
                Album data = list[0];
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(width: 16),
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  Image.network(
                                    data.coverUrlMiddle,
                                    width: 104,
                                    height: 104,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(3),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Text(
                                      _getPlayCount(data.playCount),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data.albumTitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      "内容来源：喜马拉雅APP",
                                      style: TextStyle(
                                        color: Color(0xffe1e1e1),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              data.albumIntro,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPlayList(),
                  ],
                );
              } else {
                return Container(
                  child: Text(
                    "no data",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              }
            }
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildPlayList() {
    return FutureBuilder<TrackPageList>(
        future: _trackFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  child: GestureDetector(
                    onTap: () {
                      _initTrackFuture();
                      setState(() {});
                    },
                    child: Text("load failure,click retry"),
                  ),
                ),
              );
            } else {
              TrackPageList pageList = snapshot.data;
              List<Track> list = pageList.tracks;
              if (list.isNotEmpty) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Track data = list[index];
                      return GestureDetector(
                        onTap: () => _play(list, index),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 60,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${data.orderNum + 1}",
                                      style: TextStyle(
                                        color: Color(0xff919191),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          data.trackTitle,
                                          style: TextStyle(
                                            color: Color(
                                                data.id == _currPlayTrackId
                                                    ? 0xffffa2b1
                                                    : 0xff585858),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          _getPlayCount(data.playCount),
                                          style: TextStyle(
                                            color: Color(0xff9d9d9d),
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: Text(
                                      _getTime(data.updatedAt),
                                      style: TextStyle(
                                        color: Color(0xff9d9d9d),
                                        fontSize: 11,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              Divider(
                                height: 1,
                                indent: 60,
                                color: Color(0xfff4f4f4),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: list.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            }
          } else {
            return SliverToBoxAdapter(
              child: SizedBox(),
            );
          }
        });
  }

  String _getPlayCount(int playCount) {
    return playCount >= 100000000
        ? "${(playCount * 1.0 / 100000000).toStringAsFixed(2)}亿"
        : playCount >= 10000
            ? "${(playCount * 1.0 / 10000).toStringAsFixed(2)}万"
            : playCount.toString();
  }

  String _getTime(int updateTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(updateTime);
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  _play(List<Track> list, int playIndex) async {
    Xmly xmly = Xmly();
    bool isConnected = await xmly.isConnected();
    if (isConnected) {
      await xmly.playList(list: list, playIndex: playIndex);
    } else {
      await xmly.initPlayer(
        notificationId: DateTime.now().millisecond,
        notificationClassName: "com.stevie.xmly_example.MainActivity",
      );
      _iConnectCallback = () async {
        await xmly.playList(list: list, playIndex: playIndex);
        xmly.removeOnConnectedListener(_iConnectCallback);
      };
      await xmly.addOnConnectedListener(_iConnectCallback);
    }
  }
}
