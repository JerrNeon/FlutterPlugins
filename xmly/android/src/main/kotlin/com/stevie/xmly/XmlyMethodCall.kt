package com.stevie.xmly

import com.ximalaya.ting.android.opensdk.player.XmPlayerManager
import com.ximalaya.ting.android.opensdk.player.service.IXmPlayerStatusListener

/**
 * Author：Stevie.Chen Time：2020/5/27
 * Class Comment：
 */
object Methods {
    const val isDebug = "isDebug"
    const val init = "init"
    const val setUseHttps = "setUseHttps"
    const val isTargetSDKVersion24More = "isTargetSDKVersion24More"
    const val baseGetRequest = "baseGetRequest"
    const val baseGetRequestSync = "baseGetRequestSync"
    const val basePostRequest = "basePostRequest"
    const val basePostRequestSync = "basePostRequestSync"
    const val initPlayer = "initPlayer"
    const val isConnected = "isConnected"
    const val playList = "playList"
    const val addTracksToPlayList = "addTracksToPlayList"
    const val insertTracksToPlayListHead = "insertTracksToPlayListHead"
    const val permutePlayList = "permutePlayList"
    const val getPlayList = "getPlayList"
    const val getPlayListSize = "getPlayListSize"
    const val play = "play"
    const val pause = "pause"
    const val stop = "stop"
    const val playPre = "playPre"
    const val playNext = "playNext"
    const val setPlayMode = "setPlayMode"
    const val getPlayerStatus = "getPlayerStatus"
    const val isPlaying = "isPlaying"
    const val getCurrentIndex = "getCurrentIndex"
    const val hasPreSound = "hasPreSound"
    const val hasNextSound = "hasNextSound"
    const val getDuration = "getDuration"
    const val getPlayCurrPositon = "getPlayCurrPositon"
    const val seekToByPercent = "seekToByPercent"
    const val seekTo = "seekTo"
    const val getCurrSound = "getCurrSound"
    const val getCurrPlayType = "getCurrPlayType"
    const val addOnConnectedListener = "addOnConnectedListener"
    const val removeOnConnectedListener = "removeOnConnectedListener"
    const val addPlayerStatusListener = "addPlayerStatusListener"
    const val removePlayerStatusListener = "removePlayerStatusListener"
    const val pausePlayInMillis = "pausePlayInMillis"
    const val release = "release"
}

object Arguments {
    const val method = "method"
    const val isDebug = "isDebug"
    const val AppKey = "AppKey";
    const val PackId = "PackId";
    const val AppSecret = "AppSecret";
    const val useHttps = "useHttps";
    const val isTargetSDKVersion24More = "isTargetSDKVersion24More"
    const val url = "url"
    const val params = "params"
    const val notificationId = "notificationId"
    const val notificationClassName = "notificationClassName"
    const val playList = "playList"
    const val playIndex = "playIndex"
    const val playMode = "playMode"
    const val seekPercent = "seekPercent"
    const val seekPos = "seekPos"
    const val listenerIndex = "listenerIndex"
    const val pausePlayInMillis = "pausePlayInMillis"
}

object ErrorCode {
    const val xmlyException = "xmlyException";
}

object Data {
    var connectedListenerMap: HashMap<Int, XmPlayerManager.IConnectListener>? = null
    var playerStatusListenerMap: HashMap<Int, IXmPlayerStatusListener>? = null
}