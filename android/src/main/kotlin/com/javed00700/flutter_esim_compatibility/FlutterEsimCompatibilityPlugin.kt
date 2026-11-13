package com.javed00700.flutter_esim_compatibility

import android.content.Context
import android.os.Build
import android.telephony.euicc.EuiccManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Android implementation of the `flutter_esim_compatibility` plugin.
 *
 * Verifies eSIM compatibility using [EuiccManager] on Android 9 (API level 28) and above.
 */
class FlutterEsimCompatibilityPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private var channel: MethodChannel? = null
    private var appContext: Context? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "flutter_esim_compatibility").apply {
            setMethodCallHandler(this@FlutterEsimCompatibilityPlugin)
        }
        appContext = binding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "isEsimCompatible" -> {
                result.success(isEsimCompatible())
            }
            else -> result.notImplemented()
        }
    }

    /**
     * Checks if the device supports eSIM.
     *
     * Returns true if running on API 28+ and [EuiccManager.isEnabled] is true.
     */
    internal fun isEsimCompatible(): Boolean {
        val context = appContext ?: return false
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            val euiccManager = context.getSystemService(Context.EUICC_SERVICE) as? EuiccManager
            euiccManager?.isEnabled == true
        } else {
            false
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
        appContext = null
    }
}
