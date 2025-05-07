package com.example.demo

import android.content.Context
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewRegistry
import com.example.demo.CustomWebView
import android.os.Build

private val CREATOR = object : PlatformViewFactory(null) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return CustomWebView(context)
    }
}

class WebViewFactory {
    companion object {
        fun registerWith(registry: PlatformViewRegistry) {
            registry.registerViewFactory("com.example.demo/webview", CREATOR)
        }
    }
}
