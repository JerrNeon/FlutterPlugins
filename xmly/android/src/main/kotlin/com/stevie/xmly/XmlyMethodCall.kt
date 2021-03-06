package com.stevie.xmly

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
    const val getPlayMode = "getPlayMode"
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
    const val pausePlayInMillis = "pausePlayInMillis"
    const val initListener = "initListener"
    const val removeListener = "removeListener"
    const val onConnected = "onConnected"
    const val onPlayStart = "onPlayStart"
    const val onPlayPause = "onPlayPause"
    const val onPlayStop = "onPlayStop"
    const val onSoundPlayComplete = "onSoundPlayComplete"
    const val onSoundPrepared = "onSoundPrepared"
    const val onSoundSwitch = "onSoundSwitch"
    const val onBufferingStart = "onBufferingStart"
    const val onBufferProgress = "onBufferProgress"
    const val onBufferingStop = "onBufferingStop"
    const val onPlayProgress = "onPlayProgress"
    const val onError = "onError"
    const val release = "release"
}

object Arguments {
    const val isDebug = "isDebug"
    const val appKey = "AppKey"
    const val packId = "PackId"
    const val appSecret = "AppSecret"
    const val useHttps = "useHttps"
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
    const val pausePlayInMillis = "pausePlayInMillis"
    const val progress = "progress"
    const val error = "error"
}

object ErrorCode {
    const val xmlyException = "xmlyException"
}