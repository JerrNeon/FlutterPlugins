import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_exception.dart';
import 'package:xmly/xmly_method_call.dart';

import 'models/index.dart';
import 'xmly_types.dart';

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

class Xmly {
  // 单例公开访问点
  factory Xmly() => _xmlyInstance();

  //静态私有成员，没有初始化
  static Xmly _instance;

  //私有构造函数
  Xmly._();

  // 静态、同步、私有访问点
  static Xmly _xmlyInstance() {
    if (_instance == null) {
      _instance = Xmly._();
    }
    return _instance;
  }

  static const CHANNEL_NAME = "plugins.stevie/xmly";
  static const CHANNEL_NAME2 = "plugins.stevie/xmly2";
  static const MethodChannel _channel = const MethodChannel(CHANNEL_NAME);
  static const EventChannel _eventChannel = const EventChannel(CHANNEL_NAME2);

  Map<int, IConnectCallback> _connectCallbackMap;
  Map<int, IPlayStatusCallback> _playStatusCallbackMap;
  Map<int, StreamSubscription> _connectStreamSubscriptionMap;
  Map<int, StreamSubscription> _playStatusStreamSubscriptionMap;

  ///是否显示日志
  static Future isDebug({bool isDebug = false}) {
    try {
      return _channel.invokeMethod(Methods.isDebug, {
        Arguments.isDebug: isDebug,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///初始化
  static Future init({
    @required String appKey,
    @required String packId,
    @required String appSecret,
  }) {
    try {
      return _channel.invokeMethod(Methods.init, {
        Arguments.AppKey: appKey,
        Arguments.PackId: packId,
        Arguments.AppSecret: appSecret,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///是否使用Https进行请求
  static Future useHttps({@required bool useHttps}) {
    try {
      return _channel.invokeMethod(Methods.setUseHttps, {
        Arguments.useHttps: useHttps,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///Android TargetSDk版本是否超过24
  static Future isTargetSDKVersion24More(
      {@required bool isTargetSDKVersion24More}) {
    try {
      if (Platform.isAndroid) {
        return _channel.invokeMethod(Methods.isTargetSDKVersion24More, {
          Arguments.isTargetSDKVersion24More: isTargetSDKVersion24More,
        });
      }
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

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
  }) {
    try {
      return _channel.invokeMethod(Methods.initPlayer, {
        Arguments.notificationId: notificationId,
        Arguments.notificationClassName: notificationClassName,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///是否连接
  Future<bool> isConnected() {
    try {
      return _channel.invokeMethod(Methods.isConnected);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///开始播放[list]中[playIndex]位置的数据
  Future playList({
    @required List<Track> list,
    @required int playIndex,
  }) {
    try {
      return _channel.invokeMethod(Methods.playList, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
        Arguments.playIndex: playIndex,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///添加数据到播放列表
  Future addTracksToPlayList({@required List<Track> list}) {
    try {
      return _channel.invokeMethod(Methods.addTracksToPlayList, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///插入数据到播放列表头
  Future insertTracksToPlayListHead({@required List<Track> list}) {
    try {
      return _channel.invokeMethod(Methods.insertTracksToPlayListHead, {
        Arguments.playList: list.map((e) => json.encode(e.toJson())).toList(),
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///颠倒播放列表
  Future permutePlayList() {
    try {
      return _channel.invokeMethod(Methods.permutePlayList);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

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
  Future<int> getPlayListSize() {
    try {
      return _channel.invokeMethod(Methods.getPlayListSize);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///播放
  Future play({int playIndex = -1}) {
    try {
      return _channel.invokeMethod(
          Methods.play,
          playIndex != -1
              ? {
                  Arguments.playIndex: playIndex,
                }
              : null);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///暂停
  Future pause() {
    try {
      return _channel.invokeMethod(Methods.pause);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///停止
  Future stop() {
    try {
      return _channel.invokeMethod(Methods.stop);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///播放前一首
  Future playPre() {
    try {
      return _channel.invokeMethod(Methods.playPre);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///播放后一首
  Future playNext() {
    try {
      return _channel.invokeMethod(Methods.playNext);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

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
  Future setPlayMode({@required PlayMode mode}) {
    try {
      return _channel.invokeMethod(Methods.setPlayMode, {
        Arguments.playMode: mode.index,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

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
  Future<bool> isPlaying() {
    try {
      return _channel.invokeMethod(Methods.isPlaying);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///获取当前播放索引
  Future<int> getCurrentIndex() {
    try {
      return _channel.invokeMethod(Methods.getCurrentIndex);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///是否还有前一首
  Future<bool> hasPreSound() {
    try {
      return _channel.invokeMethod(Methods.hasPreSound);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///是否还有后一首
  Future hasNextSound() {
    try {
      return _channel.invokeMethod(Methods.hasNextSound);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///获取音频时长，同Mediaplayer.getDuration()
  Future<int> getDuration() {
    try {
      return _channel.invokeMethod(Methods.getDuration);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///获取当前的播放进度
  Future<int> getPlayCurrPositon() {
    try {
      return _channel.invokeMethod(Methods.getPlayCurrPositon);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///按音频时长的比例来拖动
  Future seekToByPercent({@required double percent}) {
    try {
      return _channel.invokeMethod(Methods.seekToByPercent, {
        Arguments.seekPercent: percent,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///拖动，同Mediaplayer.seekTo();
  Future seekTo({@required int pos}) {
    try {
      return _channel.invokeMethod(Methods.seekTo, {
        Arguments.seekPos: pos,
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

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

  ///添加连接监听
  Future addOnConnectedListener(IConnectCallback callback) async {
    try {
      assert(callback != null);
      _connectCallbackMap ??= HashMap();
      _connectStreamSubscriptionMap ??= HashMap();
      int index = _connectCallbackMap.length;
      _connectCallbackMap[index] = callback;
      _connectStreamSubscriptionMap[index] =
          _eventChannel.receiveBroadcastStream({
        Arguments.method: Methods.addOnConnectedListener,
        Arguments.listenerIndex: index,
      }).listen(
        (event) {
          callback.call();
        },
        onError: (error) {},
        cancelOnError: true,
      );
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///去除连接监听
  Future removeOnConnectedListener(IConnectCallback callback) {
    try {
      assert(callback != null);
      if (_connectCallbackMap != null &&
          _connectCallbackMap.containsValue(callback)) {
        int index = -1;
        _connectCallbackMap.forEach((key, value) {
          if (value == callback) {
            index = key;
          }
        });
        if (index != -1) {
          _connectCallbackMap.remove(index);
          _connectStreamSubscriptionMap[index]?.cancel();
          _connectStreamSubscriptionMap.remove(index);
        }
      }
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///添加播放状态监听
  Future addPlayerStatusListener(IPlayStatusCallback callback) async {
    try {
      assert(callback != null);
      _playStatusCallbackMap ??= HashMap();
      _playStatusStreamSubscriptionMap ??= HashMap();
      int index = _playStatusCallbackMap.length;
      _playStatusCallbackMap[index] = callback;
      _playStatusStreamSubscriptionMap[index] =
          _eventChannel.receiveBroadcastStream({
        Arguments.method: Methods.addPlayerStatusListener,
        Arguments.listenerIndex: index,
      }).listen(
        (event) {
          event.forEach((key, value) {
            switch (key) {
              case 0:
                callback.onPlayStart?.call();
                break;
              case 1:
                callback.onSoundSwitch?.call();
                break;
              case 2:
                callback.onPlayProgress?.call(value);
                break;
              case 3:
                callback.onPlayPause?.call();
                break;
              case 4:
                callback.onBufferProgress?.call(value);
                break;
              case 5:
                callback.onPlayStop?.call();
                break;
              case 6:
                callback.onBufferingStart?.call();
                break;
              case 7:
                callback.onSoundPlayComplete?.call();
                break;
              case 8:
                callback.onError?.call(value);
                break;
              case 9:
                callback.onSoundPrepared?.call();
                break;
              case 10:
                callback.onBufferingStop?.call();
                break;
              default:
            }
          });
        },
        onError: (error) {},
        cancelOnError: true,
      );
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///去除播放状态监听
  Future removePlayerStatusListener(IPlayStatusCallback callback) {
    try {
      assert(callback != null);
      if (_playStatusCallbackMap != null &&
          _playStatusCallbackMap.containsValue(callback)) {
        int index = -1;
        _playStatusCallbackMap.forEach((key, value) {
          if (value == callback) {
            index = key;
          }
        });
        if (index != -1) {
          _playStatusCallbackMap.remove(index);
          _playStatusStreamSubscriptionMap[index]?.cancel();
          _playStatusStreamSubscriptionMap.remove(index);
        }
      }
      return Future.value();
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///定时关闭
  ///[time]填入的时间应该为当前时间+要停止的时间既(System.currentTimeMillis() + 10000 表示在10秒之后停止播放)
  ///[time] 时间单位为毫秒 传入-1表示 播放完当前歌曲关闭 传入0表示取消计划
  Future pausePlayInMillis(num timeMillis) {
    try {
      return _channel.invokeMethod(Methods.pausePlayInMillis, {
        Arguments.pausePlayInMillis: timeMillis.toString(),
      });
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }

  ///释放
  Future release() {
    try {
      return _channel.invokeMethod(Methods.release);
    } on Exception catch (e) {
      log(e.toString(), error: e);
      return Future.error(e);
    }
  }
}
