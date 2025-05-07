package com.example.demo

import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.webkit.WebChromeClient
import android.view.View
import io.flutter.plugin.platform.PlatformView

class CustomWebView(context: Context) : WebView(context), PlatformView {
    init {
        settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            databaseEnabled = true
            allowFileAccess = false
            allowContentAccess = false
            cacheMode = WebSettings.LOAD_DEFAULT
            mixedContentMode = WebSettings.MIXED_CONTENT_NEVER_ALLOW
            
            mediaPlaybackRequiresUserGesture = false
            allowFileAccessFromFileURLs = false
            allowUniversalAccessFromFileURLs = false
            setSupportZoom(false)
            builtInZoomControls = false
            displayZoomControls = false
            
            setRenderPriority(WebSettings.RenderPriority.HIGH)
            setEnableSmoothTransition(true)
            
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                setLayerType(LAYER_TYPE_HARDWARE, null)
            }
        }

        webViewClient = object : WebViewClient() {
            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                clearCache(true)
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                injectPerformanceCSS()
            }

            override fun onReceivedError(
                view: WebView?,
                errorCode: Int,
                description: String?,
                failingUrl: String?
            ) {
                super.onReceivedError(view, errorCode, description, failingUrl)
                loadUrl("about:blank")
            }
        }

        webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
            }

            override fun onReceivedTitle(view: WebView?, title: String?) {
                super.onReceivedTitle(view, title)
            }
        }
    }

    private fun injectPerformanceCSS() {
        val css = """
            * {
                will-change: auto !important;
                transform: translateZ(0) !important;
                -webkit-transform: translateZ(0) !important;
            }
            
            video {
                object-fit: contain !important;
                width: 100% !important;
                height: auto !important;
                max-width: 100% !important;
            }
            
            img {
                width: auto !important;
                height: auto !important;
                max-width: 100% !important;
            }
            
            .video-container {
                position: relative !important;
                width: 100% !important;
                height: 100% !important;
                overflow: hidden !important;
            }
        """.trimIndent()

        val js = """
            var style = document.createElement('style');
            style.textContent = '$css';
            document.head.appendChild(style);
        """.trimIndent()

        evaluateJavascript(js, null)
    }

    override fun getView(): View = this

    override fun dispose() {
        // Clean up WebView resources
        clearCache(true)
        clearHistory()
        pauseTimers()
        
        // Remove listeners
        webViewClient = object : WebViewClient() {}
        webChromeClient = object : WebChromeClient() {}
        
        // Destroy WebView
        destroy()
    }
}
