import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_plugin.dart';
import 'package:xmly_example/api_manager.dart';
import 'package:xmly_example/models/index.dart';
import 'package:xmly_example/route/album_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final xmly = Xmly();
  Future<ColumnAlbumPageList> _future;

  @override
  void initState() {
    _initFuture();
    _initListener();
    super.initState();
  }

  @override
  void dispose() {
    xmly.dispose();
    super.dispose();
  }

  _initFuture() {
    _future = ApiManager().getColumnList(id: 6880);
  }

  _initListener() {
    xmly.initListener();
    xmly.onConnected.listen((event) {
      print("home page -> onConnected");
    });
    xmly.onPlayStart.listen((event) {
      print("home page -> onPlayStart");
    });
    xmly.onPlayPause.listen((event) {
      print("home page -> onPlayPause");
    });
    xmly.onSoundPrepared.listen((event) {
      print("home page -> onSoundPrepared");
    });
    xmly.onSoundSwitch.listen((event) {
      print("home page -> onSoundSwitch");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xmly Plugin example"),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xf0f0f0),
        margin: EdgeInsets.only(top: 11),
        child: FutureBuilder<ColumnAlbumPageList>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        _initFuture();
                        setState(() {});
                      },
                      child: Text("load failure,click retry"),
                    ),
                  );
                } else {
                  ColumnAlbumPageList data = snapshot.data;
                  List<Album> list = data.values;
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        Album album = list[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AlbumDetailPage(albumId: album.id))),
                          child: Container(
                            height: 79,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            padding: EdgeInsets.all(2),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Image.network(
                                  album.coverUrlMiddle,
                                  width: 75,
                                  height: 75,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        album.albumTitle,
                                        style: TextStyle(
                                          color: Color(0xff686868),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        album.albumIntro,
                                        style: TextStyle(
                                          color: Color(0xff797979),
                                          fontSize: 12,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemCount: list.length);
                }
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
