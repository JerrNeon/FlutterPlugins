package com.stevie.xmly

import android.content.Context
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.ximalaya.ting.android.opensdk.constants.ConstantsOpenSdk
import com.ximalaya.ting.android.opensdk.datatrasfer.CommonRequest
import com.ximalaya.ting.android.opensdk.datatrasfer.IDataCallBack
import com.ximalaya.ting.android.opensdk.datatrasfer.XimalayaResponse
import com.ximalaya.ting.android.opensdk.httputil.XimalayaException
import com.ximalaya.ting.android.opensdk.model.live.radio.Radio
import com.ximalaya.ting.android.opensdk.model.live.schedule.Schedule
import com.ximalaya.ting.android.opensdk.model.track.Track
import com.ximalaya.ting.android.opensdk.player.XmPlayerManager
import com.ximalaya.ting.android.opensdk.player.appnotification.NotificationColorUtils
import com.ximalaya.ting.android.opensdk.player.appnotification.XmNotificationCreater
import com.ximalaya.ting.android.opensdk.player.constants.PlayerConstants
import com.ximalaya.ting.android.opensdk.player.service.XmPlayListControl
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
                Methods.isConnected -> {
                    result.success(XmPlayerManager.getInstance(context).isConnected)
                }
                Methods.playList -> {
                    val playList = call.argument<List<String>>(Arguments.playList)
                    val playIndex = call.argument<Int>(Arguments.playIndex)
                    val gson = Gson()
                    val list = playList?.map { gson.fromJson(it, Track::class.java) }?.toList()
                    XmPlayerManager.getInstance(context).playList(list, playIndex ?: 0)
                    result.success(true)
                }
                Methods.addTracksToPlayList -> {
                    val playList = call.argument<List<String>>(Arguments.playList)
                    val gson = Gson()
                    val list = playList?.map { gson.fromJson(it, Track::class.java) }?.toList()
                    XmPlayerManager.getInstance(context).addTracksToPlayList(list)
                    result.success(true)
                }
                Methods.insertTracksToPlayListHead -> {
                    val playList = call.argument<List<String>>(Arguments.playList)
                    val gson = Gson()
                    val list = playList?.map { gson.fromJson(it, Track::class.java) }?.toList()
                    XmPlayerManager.getInstance(context).insertTracksToPlayListHead(list)
                    result.success(true)
                }
                Methods.permutePlayList -> {
                    result.success(XmPlayerManager.getInstance(context).permutePlayList())
                }
                Methods.getPlayList -> {
                    val playList = XmPlayerManager.getInstance(context).playList
                    val gson = Gson()
                    val playStrList = playList.map { gson.toJson(it) }.toList()
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
                Methods.getPlayMode -> {
                    result.success(XmPlayerManager.getInstance(context).playMode.ordinal)
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
                    val seekPercent: Double? = call.argument<Double>(Arguments.seekPercent)
                    XmPlayerManager.getInstance(context).seekToByPercent(seekPercent?.toFloat()
                            ?: 0f)
                    result.success(true)
                }
                Methods.seekTo -> {
                    val seekPos = call.argument<Int>(Arguments.seekPos) ?: 0
                    XmPlayerManager.getInstance(context).seekTo(seekPos)
                    result.success(true)
                }
                Methods.getCurrSound -> {
                    val gson = Gson()
                    val map = hashMapOf<Int, String>()
                    when (val playableModel = XmPlayerManager.getInstance(context).currSound) {
                        is Track -> {
                            map[0] = gson.toJson(playableModel)
                        }
                        is Radio -> {
                            map[1] = gson.toJson(playableModel)
                        }
                        is Schedule -> {
                            map[2] = gson.toJson(playableModel)
                        }
                    }
                    if (map.size != 0) {
                        result.success(map)
                    } else {
                        result.success(null)
                    }
                }
                Methods.getCurrPlayType -> {
                    result.success(XmPlayerManager.getInstance(context).currPlayType)
                }
                Methods.pausePlayInMillis -> {
                    val mills = call.argument<String>(Arguments.pausePlayInMillis)?.toLongOrNull()
                            ?: 0
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