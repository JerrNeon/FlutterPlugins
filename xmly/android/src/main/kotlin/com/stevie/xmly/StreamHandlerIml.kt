package com.stevie.xmly

import android.content.Context
import com.ximalaya.ting.android.opensdk.httputil.XimalayaException
import com.ximalaya.ting.android.opensdk.model.PlayableModel
import com.ximalaya.ting.android.opensdk.player.XmPlayerManager
import com.ximalaya.ting.android.opensdk.player.service.IXmPlayerStatusListener
import com.ximalaya.ting.android.opensdk.player.service.XmPlayerException
import io.flutter.plugin.common.EventChannel
import java.io.IOException

/**
 * Author：Stevie.Chen Time：2020/6/2
 * Class Comment：
 */
class StreamHandlerIml(private val context: Context) : EventChannel.StreamHandler {

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        try {
            if (arguments is Map<*, *>) {
                val method = arguments[Arguments.method] as? String ?: ""
                val index = arguments[Arguments.listenerIndex] as? Int ?: 0
                if (method.contains(Methods.addOnConnectedListener)) {
                    when (method) {
                        "${Methods.addOnConnectedListener}$index" -> {
                            if (Data.connectedListenerMap == null)
                                Data.connectedListenerMap = hashMapOf()
                            XmPlayerManager.getInstance(context).addOnConnectedListerner(object : XmPlayerManager.IConnectListener {
                                override fun onConnected() {
                                    Data.connectedListenerMap!![index] = this
                                    events?.success(true)
                                }
                            })
                        }
                    }
                } else if (method.contains(Methods.addPlayerStatusListener)) {
                    when (method) {
                        "${Methods.addPlayerStatusListener}$index" -> {
                            val playerStatusListener = PlayerStatusListenerIml(events)
                            if (Data.playerStatusListenerMap == null)
                                Data.playerStatusListenerMap = hashMapOf()
                            Data.playerStatusListenerMap!![index] = playerStatusListener
                            XmPlayerManager.getInstance(context).addPlayerStatusListener(playerStatusListener)
                        }
                    }
                }
            }
        } catch (e: XimalayaException) {
            events?.error(ErrorCode.xmlyException, e.errorCode.toString(), e.errorMessage)
        } catch (e: IOException) {
            val errorCode: String =
                    if (arguments is String)
                        arguments
                    else arguments?.toString() ?: ""
            events?.error(errorCode, "IOException encountered", e)
        } catch (e: Exception) {
            val errorCode: String =
                    if (arguments is String)
                        arguments
                    else arguments?.toString() ?: ""
            events?.error(errorCode, "Exception encountered", e)
        }
    }

    override fun onCancel(arguments: Any?) {
        if (arguments is Map<*, *>) {
            val method = arguments[Arguments.method] as? String ?: ""
            val index = arguments[Arguments.listenerIndex] as? Int ?: 0
            when (method) {
                "${Methods.addOnConnectedListener}$index" -> {
                    Data.connectedListenerMap?.let {
                        if (it.containsKey(index)) {
                            XmPlayerManager.getInstance(context).removeOnConnectedListerner(it[index])
                        }
                    }
                }
                "${Methods.addPlayerStatusListener}$index" -> {
                    Data.playerStatusListenerMap?.let {
                        if (it.containsKey(index)) {
                            XmPlayerManager.getInstance(context).removePlayerStatusListener(it[index])
                        }
                    }
                }
            }
        }
    }

    class PlayerStatusListenerIml(private val events: EventChannel.EventSink?) : IXmPlayerStatusListener {
        override fun onPlayStart() {
            val map = hashMapOf(0 to 0)
            events?.success(map)
        }

        override fun onSoundSwitch(p0: PlayableModel?, p1: PlayableModel?) {
            val map = hashMapOf(1 to 1)
            events?.success(map)
        }

        override fun onPlayProgress(currPos: Int, duration: Int) {
            val map = hashMapOf(2 to currPos * 1f / duration)
            events?.success(map)
        }

        override fun onPlayPause() {
            val map = hashMapOf(3 to 3)
            events?.success(map)
        }

        override fun onBufferProgress(progress: Int) {
            val map = hashMapOf(4 to progress)
            events?.success(map)
        }

        override fun onPlayStop() {
            val map = hashMapOf(5 to 5)
            events?.success(map)
        }

        override fun onBufferingStart() {
            val map = hashMapOf(6 to 6)
            events?.success(map)
        }

        override fun onSoundPlayComplete() {
            val map = hashMapOf(7 to 7)
            events?.success(map)
        }

        override fun onError(e: XmPlayerException?): Boolean {
            val map = hashMapOf(8 to e.toString())
            events?.success(map)
            return false
        }

        override fun onSoundPrepared() {
            val map = hashMapOf(9 to 9)
            events?.success(map)
        }

        override fun onBufferingStop() {
            val map = hashMapOf(10 to 10)
            events?.success(map)
        }
    }
}