package com.codewithejaz.esim_compatibility

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

internal class EsimCompatibilityPluginTest {
    @Test
    fun onMethodCall_isEsimCompatible_returnsExpectedValue() {
        val plugin = EsimCompatibilityPlugin()

        val call = MethodCall("isEsimCompatible", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        // Without a real Android context, isEsimCompatible() returns false safely.
        Mockito.verify(mockResult).success(false)
    }

    @Test
    fun onMethodCall_unknownMethod_returnsNotImplemented() {
        val plugin = EsimCompatibilityPlugin()

        val call = MethodCall("unknownMethod", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).notImplemented()
    }
}
