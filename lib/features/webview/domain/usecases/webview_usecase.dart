import 'package:demo/features/webview/domain/repositories/webview_repository.dart';
import 'package:demo/features/webview/data/repositories/webview_repository_impl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewUseCase {
  late final WebViewRepository _repository;
  late final WebViewController _webViewController;

  WebViewUseCase() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            // Inject CSS to improve performance on Fire TV
            _webViewController.runJavaScript('''
              var style = document.createElement('style');
              style.textContent = `
                * {
                  will-change: auto !important;
                  transform: translateZ(0) !important;
                }
                video {
                  object-fit: contain !important;
                  width: 100% !important;
                  height: auto !important;
                }
              `;
              document.head.appendChild(style);
            ''');
          },
          onWebResourceError: (WebResourceError error) {
            print('Page resource error: ${error.description}');
          },
        ),
      )
      ..setUserAgent('Mozilla/5.0 (Linux; Android 9; AFTSSS Build/PQ3A.190801.002; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.119 Mobile Safari/537.36')
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          print('Received message: ${message.message}');
        },
      )
      ..loadRequest(Uri.parse('https://dev-signage.lotusdm.com/template/grid-template-1/108'));
    _repository = WebViewRepositoryImpl(_webViewController);
  }

  WebViewController get webViewController => _webViewController;

  Future<void> loadUrl(String url) => _repository.loadUrl(url);
  Future<void> goBack() => _repository.goBack();
  Future<void> goForward() => _repository.goForward();
  Future<void> reload() => _repository.reload();
  Future<bool> canGoBack() => _repository.canGoBack();
  Future<bool> canGoForward() => _repository.canGoForward();
  Future<void> clearCache() => _repository.clearCache();
}
