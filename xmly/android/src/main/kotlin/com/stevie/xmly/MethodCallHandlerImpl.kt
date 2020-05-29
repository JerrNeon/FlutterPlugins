package com.stevie.xmly

import android.content.Context
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.stevie.xmly.Data.connectedListenerMap
import com.stevie.xmly.Data.playerStatusListenerMap
import com.ximalaya.ting.android.opensdk.constants.ConstantsOpenSdk
import com.ximalaya.ting.android.opensdk.datatrasfer.CommonRequest
import com.ximalaya.ting.android.opensdk.datatrasfer.IDataCallBack
import com.ximalaya.ting.android.opensdk.datatrasfer.XimalayaResponse
import com.ximalaya.ting.android.opensdk.httputil.XimalayaException
import com.ximalaya.ting.android.opensdk.model.PlayableModel
import com.ximalaya.ting.android.opensdk.model.live.radio.Radio
import com.ximalaya.ting.android.opensdk.model.live.schedule.Schedule
import com.ximalaya.ting.android.opensdk.model.track.Track
import com.ximalaya.ting.android.opensdk.player.XmPlayerManager
import com.ximalaya.ting.android.opensdk.player.appnotification.NotificationColorUtils
import com.ximalaya.ting.android.opensdk.player.appnotification.XmNotificationCreater
import com.ximalaya.ting.android.opensdk.player.constants.PlayerConstants
import com.ximalaya.ting.android.opensdk.player.service.IXmPlayerStatusListener
import com.ximalaya.ting.android.opensdk.player.service.XmPlayListControl
import com.ximalaya.ting.android.opensdk.player.service.XmPlayerException
import com.ximalaya.ting.android.opensdk.util.BaseUtil
import com.ximalaya.ting.android.player.XMediaPlayerConstants
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.lang.Exception

/**
 * Author：Stevie.Chen Time：2020/5/27
 * Class Comment：
 */
class MethodCallHandlerImpl(private val context: Context) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        try {
            when (call.method) {
                Methods.isDebug -> {
                    val isDebug = call.argument<Boolean>(Arguments.isDebug) ?: false
                    ConstantsOpenSdk.isDebug = isDebug
                    XMediaPlayerConstants.isDebug = isDebug
                    result.success(true)
                }
                Methods.init -> {
                    if (BaseUtil.isMainProcess(context)) {
                        val appKey = call.argument<String>(Arguments.AppKey)
                        val packId = call.argument<String>(Arguments.PackId)
                        val appSecret = call.argument<String>(Arguments.AppSecret)
                        CommonRequest.getInstanse().setAppkey(appKey)
                        CommonRequest.getInstanse().setPackid(packId)
                        CommonRequest.getInstanse().init(context, appSecret)
                        result.success(true)
                    }
                }
                Methods.setUseHttps -> {
                    if (BaseUtil.isMainProcess(context)) {
                        val useHttps = call.argument<Boolean>(Arguments.useHttps)
                        CommonRequest.getInstanse().useHttps = useHttps ?: false
                        result.success(true)
                    }
                }
                Methods.isTargetSDKVersion24More -> {
                    val isTargetSDKVersion24More = call.argument<Boolean>(Arguments.isTargetSDKVersion24More)
                    NotificationColorUtils.isTargerSDKVersion24More = isTargetSDKVersion24More
                            ?: false
                    result.success(true)
                }
                Methods.baseGetRequest -> {
                    val url = call.argument<String>(Arguments.url)
                    val param = call.argument<Map<String, String>>(Arguments.params)
                    CommonRequest.baseGetRequest(url, param, object : IDataCallBack<XmResponse> {
                        override fun onSuccess(p0: XmResponse?) {
                            result.success(p0?.json)
                        }

                        override fun onError(p0: Int, p1: String?) {
                            result.error(ErrorCode.xmlyException, p0.toString(), p1)
                        }
                    }, object : IRequestCallBack<XmResponse> {
                        override fun success(var1: String?): XmResponse {
                            return XmResponse(var1)
                        }
                    })
                }
                Methods.baseGetRequestSync -> {
                    val url = call.argument<String>(Arguments.url)
                    val param = call.argument<Map<String, String>>(Arguments.params)
                    val response = CommonRequest.baseGetReqeustSync(url, param, object : IRequestCallBack<String> {
                        override fun success(var1: String?): String {
                            return var1 ?: ""
                        }
                    })
                    result.success(response)
                }
                Methods.basePostRequest -> {
                    val url = call.argument<String>(Arguments.url)
                    val param = call.argument<Map<String, String>>(Arguments.params)
                    CommonRequest.basePostRequest(url, param, object : IDataCallBack<XmResponse> {
                        override fun onSuccess(p0: XmResponse?) {
                            result.success(p0?.json)
                        }

                        override fun onError(p0: Int, p1: String?) {
                            result.error(ErrorCode.xmlyException, p0.toString(), p1)
                        }
                    }, object : IRequestCallBack<XmResponse> {
                        override fun success(var1: String?): XmResponse {
                            return XmResponse(var1)
                        }
                    })
                }
                Methods.basePostRequestSync -> {
                    val url = call.argument<String>(Arguments.url)
                    val param = call.argument<Map<String, String>>(Arguments.params)
                    val response = CommonRequest.basePostRequestSync(url, param, object : IRequestCallBack<String> {
                        override fun success(var1: String?): String {
                            return var1 ?: ""
                        }
                    })
                    result.success(response)
                }
                Methods.initPlayer -> {
                    val notificationId = call.argument<Int>(Arguments.notificationId)
                    val notificationClassName = call.argument<String>(Arguments.notificationClassName)
                    val notification = XmNotificationCreater.getInstanse(context).initNotification(context, Class.forName(notificationClassName
                            ?: ""))
                    XmPlayerManager.getInstance(context).init(notificationId
                            ?: System.currentTimeMillis().toInt(), notification)
                    result.success(true)
                }
                Methods.playList -> {
                    val playList = call.argument<List<Map<String, Any>>>(Arguments.playList)
                    val playIndex = call.argument<Int>(Arguments.playIndex)
                    val list = mutableListOf<Track>()
                    val gson = Gson()
                    playList?.asIterable()?.forEach {
                        list.add(gson.fromJson(gson.toJson(it), Track::class.java))
                    }
                    XmPlayerManager.getInstance(context).playList(list, playIndex ?: 0)
                    result.success(true)
                }
                Methods.addTracksToPlayList -> {
                    val playList = call.argument<List<Map<String, Any>>>(Arguments.playList)
                    val list = mutableListOf<Track>()
                    val gson = Gson()
                    playList?.asIterable()?.forEach {
                        list.add(gson.fromJson(gson.toJson(it), Track::class.java))
                    }
                    XmPlayerManager.getInstance(context).addTracksToPlayList(list)
                    result.success(true)
                }
                Methods.insertTracksToPlayListHead -> {
                    val playList = call.argument<List<Map<String, Any>>>(Arguments.playList)
                    val list = mutableListOf<Track>()
                    val gson = Gson()
                    playList?.asIterable()?.forEach {
                        list.add(gson.fromJson(gson.toJson(it), Track::class.java))
                    }
                    XmPlayerManager.getInstance(context).insertTracksToPlayListHead(list)
                    result.success(true)
                }
                Methods.getPlayList -> {
                    val playList = XmPlayerManager.getInstance(context).playList
                    val gson = Gson()
                    val playStrList = playList.map { gson.fromJson<HashMap<String, Any?>>(gson.toJson(it), object : TypeToken<HashMap<String, Any?>>() {}.type) }.toList()
                    result.success(playStrList)
                }
                Methods.getPlayListSize -> {
                    result.success(XmPlayerManager.getInstance(context).playListSize)
                }
                Methods.play -> {
                    val playIndex = call.argument<Int>(Arguments.playIndex)
                    if (playIndex != null) {
                        XmPlayerManager.getInstance(context).play(playIndex)
                    } else {
                        XmPlayerManager.getInstance(context).play()
                    }
                    result.success(true)
                }
                Methods.pause -> {
                    XmPlayerManager.getInstance(context).pause()
                    result.success(true)
                }
                Methods.stop -> {
                    XmPlayerManager.getInstance(context).stop()
                    result.success(true)
                }
                Methods.playPre -> {
                    XmPlayerManager.getInstance(context).playPre()
                    result.success(true)
                }
                Methods.playNext -> {
                    XmPlayerManager.getInstance(context).playNext()
                    result.success(true)
                }
                Methods.setPlayMode -> {
                    val playMode = call.argument<Int>(Arguments.playMode)
                            ?: XmPlayListControl.PlayMode.PLAY_MODEL_LIST.ordinal
                    XmPlayerManager.getInstance(context).playMode = XmPlayListControl.PlayMode.getIndex(playMode)
                    result.success(true)
                }
                Methods.getPlayerStatus -> {
                    PlayerConstants.STATE_STARTED
                    result.success(XmPlayerManager.getInstance(context).playerStatus)
                }
                Methods.isPlaying -> {
                    result.success(XmPlayerManager.getInstance(context).isPlaying)
                }
                Methods.getCurrentIndex -> {
                    result.success(XmPlayerManager.getInstance(context).currentIndex)
                }
                Methods.hasPreSound -> {
                    result.success(XmPlayerManager.getInstance(context).hasPreSound())
                }
                Methods.hasNextSound -> {
                    result.success(XmPlayerManager.getInstance(context).hasNextSound())
                }
                Methods.getDuration -> {
                    result.success(XmPlayerManager.getInstance(context).duration)
                }
                Methods.getPlayCurrPositon -> {
                    result.success(XmPlayerManager.getInstance(context).playCurrPositon)
                }
                Methods.seekToByPercent -> {
                    val seekPercent = call.argument<Float>(Arguments.seekPercent) ?: 0f
                    XmPlayerManager.getInstance(context).seekToByPercent(seekPercent)
                    result.success(true)
                }
                Methods.seekTo -> {
                    val seekPos = call.argument<Int>(Arguments.seekPos) ?: 0
                    XmPlayerManager.getInstance(context).seekTo(seekPos)
                    result.success(true)
                }
                Methods.getCurrSound -> {
                    val gson = Gson()
                    val map = hashMapOf<Int, HashMap<String, Any?>>()
                    when (val playableModel = XmPlayerManager.getInstance(context).currSound) {
                        is Track -> {
                            map[0] = gson.fromJson(gson.toJson(playableModel), object : TypeToken<HashMap<String, Any?>>() {}.type)
                        }
                        is Radio -> {
                            map[1] = gson.fromJson(gson.toJson(playableModel), object : TypeToken<HashMap<String, Any?>>() {}.type)
                        }
                        is Schedule -> {
                            map[2] = gson.fromJson(gson.toJson(playableModel), object : TypeToken<HashMap<String, Any?>>() {}.type)
                        }
                    }
                    result.success(map)
                }
                Methods.getCurrPlayType -> {
                    result.success(XmPlayerManager.getInstance(context).currPlayType)
                }
                Methods.addOnConnectedListener -> {
                    val index = call.argument<Int>(Arguments.listenerIndex) ?: 0
                    if (connectedListenerMap == null)
                        connectedListenerMap = hashMapOf()
                    XmPlayerManager.getInstance(context).addOnConnectedListerner(object : XmPlayerManager.IConnectListener {
                        override fun onConnected() {
                            connectedListenerMap!![index] = this
                            result.success(true)
                        }
                    })
                }
                Methods.removeOnConnectedListener -> {
                    val index = call.argument<Int>(Arguments.listenerIndex) ?: 0
                    connectedListenerMap?.let {
                        if (it.containsKey(index)) {
                            XmPlayerManager.getInstance(context).removeOnConnectedListerner(it[index])
                        }
                    }
                }
                Methods.addPlayerStatusListener -> {
                    val index = call.argument<Int>(Arguments.listenerIndex) ?: 0
                    val playerStatusListener = PlayerStatusListenerIml(result)
                    if (playerStatusListenerMap == null)
                        playerStatusListenerMap = hashMapOf()
                    playerStatusListenerMap!![index] = playerStatusListener
                    XmPlayerManager.getInstance(context).addPlayerStatusListener(playerStatusListener)
                }
                Methods.removePlayerStatusListener -> {
                    val index = call.argument<Int>(Arguments.listenerIndex) ?: 0
                    playerStatusListenerMap?.let {
                        if (it.containsKey(index)) {
                            XmPlayerManager.getInstance(context).removePlayerStatusListener(it[index])
                        }
                    }
                }
                Methods.pausePlayInMillis -> {
                    val mills = call.argument<Long>(Arguments.pausePlayInMillis) ?: 0
                    XmPlayerManager.getInstance(context).pausePlayInMillis(mills)
                    result.success(true)
                }
                Methods.release -> {
                    XmPlayerManager.release()
                    CommonRequest.release()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        } catch (e: XimalayaException) {
            result.error(ErrorCode.xmlyException, e.errorCode.toString(), e.errorMessage)
        } catch (e: IOException) {
            result.error(call.method, "IOException encountered", e)
        } catch (e: Exception) {
            result.error(call.method, "Exception encountered", e)
        }
    }
}

data class XmResponse(val json: String?) : XimalayaResponse()

class PlayerStatusListenerIml(private val result: MethodChannel.Result) : IXmPlayerStatusListener {
    override fun onPlayStart() {
        val map = hashMapOf(0 to 0)
        result.success(map)
    }

    override fun onSoundSwitch(p0: PlayableModel?, p1: PlayableModel?) {
        val map = hashMapOf(1 to 1)
        result.success(map)
    }

    override fun onPlayProgress(currPos: Int, duration: Int) {
        val map = hashMapOf(2 to currPos * 1f / duration)
        result.success(map)
    }

    override fun onPlayPause() {
        val map = hashMapOf(3 to 3)
        result.success(map)
    }

    override fun onBufferProgress(progress: Int) {
        val map = hashMapOf(4 to progress)
        result.success(map)
    }

    override fun onPlayStop() {
        val map = hashMapOf(5 to 5)
        result.success(map)
    }

    override fun onBufferingStart() {
        val map = hashMapOf(6 to 6)
        result.success(map)
    }

    override fun onSoundPlayComplete() {
        val map = hashMapOf(7 to 7)
        result.success(map)
    }

    override fun onError(e: XmPlayerException?): Boolean {
        val map = hashMapOf(8 to e.toString())
        result.success(map)
        return false
    }

    override fun onSoundPrepared() {
        val map = hashMapOf(9 to 9)
        result.success(map)
    }

    override fun onBufferingStop() {
        val map = hashMapOf(10 to 10)
        result.success(map)
    }
}