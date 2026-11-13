package com.javed00700.flutter_esim_compatibility

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

internal class FlutterEsimCompatibilityPluginTest {
    @Test
    fun onMethodCall_isEsimCompatible_returnsExpectedValue() {
        val plugin = FlutterEsimCompatibilityPlugin()

        val call = MethodCall("isEsimCompatible", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        // Without a real Android context, isEsimCompatible() returns false safely.
        Mockito.verify(mockResult).success(false)
    }

    @Test
    fun onMethodCall_unknownMethod_returnsNotImplemented() {
        val plugin = FlutterEsimCompatibilityPlugin()

        val call = MethodCall("unknownMethod", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).notImplemented()
    }
}
