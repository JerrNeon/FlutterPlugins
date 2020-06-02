package com.stevie.xmly

import android.content.Context
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.*
import io.flutter.plugin.common.PluginRegistry.Registrar

/** XmlyPlugin */
public class XmlyPlugin : FlutterPlugin {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        const val CHANNEL_NAME = "plugins.stevie/xmly"
        const val CHANNEL_NAME2 = "plugins.stevie/xmly2"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = XmlyPlugin()
            plugin.setupChannel(registrar.messenger(), registrar.context())
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupChannel(flutterPluginBinding.binaryMessenger, flutterPluginBinding.applicationContext)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        teardownChannel()
    }

    private fun setupChannel(messenger: BinaryMessenger, context: Context) {
        methodChannel = MethodChannel(messenger, CHANNEL_NAME)
        val methodCallHandler = MethodCallHandlerImpl(context)
        methodChannel.setMethodCallHandler(methodCallHandler)

        eventChannel = EventChannel(messenger, CHANNEL_NAME2)
        val streamHandler = StreamHandlerIml(context)
        eventChannel.setStreamHandler(streamHandler)
    }

    private fun teardownChannel() {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }
}
