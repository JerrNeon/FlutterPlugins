import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/src/xmly_exception.dart';
import 'package:xmly/src/xmly_method_call.dart';

import '../models/index.dart';

enum PlayMode {
  PLAY_MODEL_SINGLE, //单曲播放
  PLAY_MODEL_SINGLE_LOOP, //单曲循环
  PLAY_MODEL_LIST, //列表播放
  PLAY_MODEL_LIST_LOOP, //列表循序
  PLAY_MODEL_RANDOM //随机播放
}

enum PlayerStatus {
  STATE_IDLE,
  STATE_INITIALIZED,
  STATE_PREPARED,
  STATE_STARTED,
  STATE_STOPPED,
  STATE_PAUSED,
  STATE_COMPLETED,
  STATE_ERROR,
  STATE_END,
  STATE_PREPARING,
  STATE_ADS_BUFFERING,
  STATE_PLAYING_ADS
}

enum PlayType {
  PLAY_SOURCE_NONE,
  PLAY_SOURCE_TRACK,
  PLAY_SOURCE_RADIO,
}

const _kChannel = "plugins.stevie/xmly";

class Xmly {
  final MethodChannel _channel;

  // 单例公开访问点
  factory Xmly() => _xmlyInstance();

  //静态私有成员，没有初始化
  static Xmly _instance;

  //私有构造函数
  Xmly._(this._channel) {
    _channel.setMethodCallHandler(_handleMessages);
  }

  // 静态、同步、私有访问点
  static Xmly _xmlyInstance() {
    if (_instance == null) {
      const channel = const MethodChannel(_kChannel);
      _instance = Xmly._(channel);
    }
    return _instance;
  }

  final _onConnected = StreamController<Null>.broadcast();
  final _onPlayStart = StreamController<Null>.broadcast();
  final _onPlayPause = StreamController<Null>.broadcast();
  final _onPlayStop = StreamController<Null>.broadcast();
  final _onSoundPlayComplete = StreamController<Null>.broadcast();
  final _onSoundPrepared = StreamController<Null>.broadcast();
  final _onSoundSwitch = StreamController<Null>.broadcast();
  final _onBufferingStart = StreamController<Null>.broadcast();
  final _onBufferProgress = StreamController<int>.broadcast();
  final _onBufferingStop = StreamController<Null>.broadcast();
  final _onPlayProgress = StreamController<double>.broadcast();
  final _onError = StreamController<String>.broadcast();

  Stream<Null> get onConnected => _onConnected.stream;
  Stream<Null> get onPlayStart => _onPlayStart.stream;
  Stream<Null> get onPlayPause => _onPlayPause.stream;
  Stream<Null> get onPlayStop => _onPlayStop.stream;
  Stream<Null> get onSoundPlayComplete => _onSoundPlayComplete.stream;
  Stream<Null> get onSoundPrepared => _onSoundPrepared.stream;
  Stream<Null> get onSoundSwitch => _onSoundSwitch.stream;
  Stream<Null> get onBufferingStart => _onBufferingStart.stream;
  Stream<int> get onBufferProgress => _onBufferProgress.stream;
  Stream<Null> get onBufferingStop => _onBufferingStop.stream;
  Stream<double> get onPlayProgress => _onPlayProgress.stream;
  Stream<String> get onError => _onError.stream;

  ///处理Native端发送过来的Message
  Future _handleMessages(MethodCall call) async {
    switch (call.method) {
      case Methods.onConnected: //已连接
        _onConnected.add(null);
        break;
      case Methods.onPlayStart: //播放开始
        _onPlayStart.add(null);
        break;
      case Methods.onPlayPause: //播放暂停
        _onPlayPause.add(null);
        break;
      case Methods.onPlayStop: //播放停止
        _onPlayStop.add(null);
        break;
      case Methods.onSoundPlayComplete: //播放完成
        _onSoundPlayComplete.add(null);
        break;
      case Methods.onSoundPrepared: //播放准备中
        _onSoundPrepared.add(null);
        break;
      case Methods.onSoundSwitch: //切歌
        _onSoundSwitch.add(null);
        break;
      case Methods.onBufferingStart: //缓冲开始
        _onBufferingStart.add(null);
        break;
      case Methods.onBufferProgress: //缓冲中
        _onBufferProgress.add(call.arguments[Arguments.progress]);
        break;
      case Methods.onBufferingStop: //缓冲完成
        _onBufferingStop.add(null);
        break;
      case Methods.onPlayProgress: //播放中
        _onPlayProgress.add(call.arguments[Arguments.progress]);
        break;
      case Methods.onError: //播放出现错误
        _onError.add(call.arguments[Arguments.error]);
        break;
      default:
    }
  }

  ///是否显示日志
  Future isDebug({bool isDebug = false}) =>
      _channel.invokeMethod(Methods.isDebug, {
        Arguments.isDebug: isDebug,
      });

  ///初始化
  Future init({
    @required String appKey,
    @required String packId,
    @required String appSecret,
  }) =>
      _channel.invokeMethod(Methods.init, {
        Arguments.appKey: appKey,
        Arguments.packId: packId,
        Arguments.appSecret: appSecret,
      });

  ///是否使用Https进行请求
  Future useHttps({@required bool useHttps}) =>
      _channel.invokeMethod(Methods.setUseHttps, {
        Arguments.useHttps: useHttps,
      });

  ///Android TargetSDk版本是否超过24
  Future isTargetSDKVersion24More({@required bool isTargetSDKVersion24More}) =>
      Platform.isAndroid
          ? _channel.invokeMethod(Methods.isTargetSDKVersion24More, {
              Arguments.isTargetSDKVersion24More: isTargetSDKVersion24More,
            })
          : null;

  ///异步Get请求
  Future<String> baseGetRequest({
    @required String url,
    Map<String, String> params,
  }) {
    try {
      return _channel.invokeMethod(Methods.baseGetRequest, {
        Arguments.url: url,
        Arguments.params: params,
      });
    } on PlatformException catch (e) {
      if (e.code == ErrorCode.xmlyException) {
        throw XmlyException(code: e.message, message: e.details);
      } else {
        throw e;
      }
    }
  }

  ///同步Get请求
  Future<String> baseGetRequestSync({
    @required String url,
    Map<String, String> params,
  }) {
    try {
      return _channel.invokeMethod(Methods.baseGetRequestSync, {
        Arguments.url: url,
        Arguments.params: params,
      });
    } on PlatformException catch (e) {
      if (e.code == ErrorCode.xmlyException) {
        throw XmlyException(code: e.message, message: e.details);
      } else {
        throw e;
      }
    }
  }

  ///异步Post请求
  Future<String> basePostRequest({
    @required String url,
    Map<String, String> params,
  }) {
    try {
      return _channel.invokeMethod(Methods.basePostRequest, {
        Arguments.url: url,
        Arguments.params: params,
      });
    } on PlatformException catch (e) {
      if (e.code == ErrorCode.xmlyException) {
        throw XmlyException(code: e.message, message: e.details);
      } else {
        throw e;
      }
    }
  }

  ///同步Get请求
  Future<String> basePostRequestSync({
    @required String url,
    Map<String, String> params,
  }) {
    try {
      return _channel.invokeMethod(Methods.basePostRequestSync, {
        Arguments.url: url,
        Arguments.params: params,
      });
    } on PlatformException catch (e) {
      if (e.code == ErrorCode.xmlyException) {
        throw XmlyException(code: e.message, message: e.details);
      } else {
        throw e;
      }
    }
  }

  ///初始化播放器
  Future initPlayer({
    @required int notificationId,
    @required String notificationClassName,
  }) =>
      _channel.invokeMethod(Methods.initPlayer, {
        Arguments.notificationId: notificationId,
        Arguments.notificationClassName: notificationClassName,
      });

  ///是否连接
  Future<bool> isConnected() => _channel.invokeMethod(Methods.isConnected);

  ///开始播放[list]中[playIndex]位置的数据
  Future playList({
    @required List<Track> list,
    @required int playIndex,
  }) =>
      _channel.invokeMethod(Methods.playList, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
        Arguments.playIndex: playIndex,
      });

  ///添加数据到播放列表
  Future addTracksToPlayList({@required List<Track> list}) =>
      _channel.invokeMethod(Methods.addTracksToPlayList, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
      });

  ///插入数据到播放列表头
  Future insertTracksToPlayListHead({@required List<Track> list}) =>
      _channel.invokeMethod(Methods.insertTracksToPlayListHead, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
      });

  ///颠倒播放列表
  Future permutePlayList() => _channel.invokeMethod(Methods.permutePlayList);

  ///获取播放列表
  Future<List<Track>> getPlayList() async {
    try {
      List<String> list = await _channel.invokeListMethod(Methods.getPlayList);
      return list.map((e) => Track.fromJson(json.decode(e))).toList();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///获取播放列表数据总数
  Future<int> getPlayListSize() =>
      _channel.invokeMethod(Methods.getPlayListSize);

  ///播放
  Future play({int playIndex = -1}) => _channel.invokeMethod(
      Methods.play, playIndex != -1 ? {Arguments.playIndex: playIndex} : null);

  ///暂停
  Future pause() => _channel.invokeMethod(Methods.pause);

  ///停止
  Future stop() => _channel.invokeMethod(Methods.stop);

  ///播放前一首
  Future playPre() => _channel.invokeMethod(Methods.playPre);

  ///播放后一首
  Future playNext() => _channel.invokeMethod(Methods.playNext);

  ///获取播放模式
  Future<PlayMode> getPlayMode() async {
    try {
      int index = await _channel.invokeMethod(Methods.getPlayMode);
      return PlayMode.values[index];
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///设置播放模式
  Future setPlayMode({@required PlayMode mode}) =>
      _channel.invokeMethod(Methods.setPlayMode, {
        Arguments.playMode: mode.index,
      });

  ///获取播放状态
  Future<PlayerStatus> getPlayerStatus() async {
    try {
      int index = await _channel.invokeMethod(Methods.getPlayerStatus);
      return PlayerStatus.values[index];
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///是否正在播放
  Future<bool> isPlaying() => _channel.invokeMethod(Methods.isPlaying);

  ///获取当前播放索引
  Future<int> getCurrentIndex() =>
      _channel.invokeMethod(Methods.getCurrentIndex);

  ///是否还有前一首
  Future<bool> hasPreSound() => _channel.invokeMethod(Methods.hasPreSound);

  ///是否还有后一首
  Future hasNextSound() => _channel.invokeMethod(Methods.hasNextSound);

  ///获取音频时长，同Mediaplayer.getDuration()
  Future<int> getDuration() => _channel.invokeMethod(Methods.getDuration);

  ///获取当前的播放进度
  Future<int> getPlayCurrPositon() =>
      _channel.invokeMethod(Methods.getPlayCurrPositon);

  ///按音频时长的比例来拖动
  Future seekToByPercent({@required double percent}) =>
      _channel.invokeMethod(Methods.seekToByPercent, {
        Arguments.seekPercent: percent,
      });

  ///拖动，同Mediaplayer.seekTo();
  Future seekTo({@required int pos}) => _channel.invokeMethod(Methods.seekTo, {
        Arguments.seekPos: pos,
      });

  ///获取当前的正在播放的声音信息
  Future<Track> getCurrSound() async {
    try {
      Map<int, String> map =
          await _channel.invokeMapMethod(Methods.getCurrSound);
      if (map != null && map.containsKey(0)) {
        return Track.fromJson(json.decode(map[0]));
      }
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///获取当前的播放类型
  Future<PlayType> getCurrPlayType() async {
    try {
      int index = await _channel.invokeMethod(Methods.getCurrPlayType);
      return PlayType.values[index - 1];
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///定时关闭
  ///[time]填入的时间应该为当前时间+要停止的时间既(System.currentTimeMillis() + 10000 表示在10秒之后停止播放)
  ///[time] 时间单位为毫秒 传入-1表示 播放完当前歌曲关闭 传入0表示取消计划
  Future pausePlayInMillis(num timeMillis) =>
      _channel.invokeMethod(Methods.pausePlayInMillis, {
        Arguments.pausePlayInMillis: timeMillis.toString(),
      });

  ///初始化连接监听和播放状态监听
  Future initListener() => _channel.invokeMethod(Methods.initListener);

  ///去除连接监听和播放状态监听
  Future removeListener() => _channel.invokeMethod(Methods.removeListener);

  ///释放播放器(退出之前调用)
  Future release() => _channel.invokeMethod(Methods.release);

  /// Close all Streams
  dispose() {
    removeListener();
    _onConnected.close();
    _onPlayStart.close();
    _onPlayPause.close();
    _onPlayStop.close();
    _onSoundPlayComplete.close();
    _onSoundPrepared.close();
    _onSoundSwitch.close();
    _onBufferingStart.close();
    _onBufferProgress.close();
    _onBufferingStop.close();
    _onPlayProgress.close();
    _onError.close();
    _instance = null;
  }
}
