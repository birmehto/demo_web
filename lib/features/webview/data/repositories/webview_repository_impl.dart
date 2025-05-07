import 'package:demo/features/webview/domain/repositories/webview_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewRepositoryImpl implements WebViewRepository {
  final WebViewController _webViewController;

  WebViewRepositoryImpl(this._webViewController);

  @override
  Future<void> loadUrl(String url) async {
    await _webViewController.loadRequest(Uri.parse(url));
  }

  @override
  Future<void> goBack() async {
    if (await _webViewController.canGoBack()) {
      await _webViewController.goBack();
    }
  }

  @override
  Future<void> goForward() async {
    if (await _webViewController.canGoForward()) {
      await _webViewController.goForward();
    }
  }

  @override
  Future<void> reload() async {
    await _webViewController.reload();
  }

  @override
  Future<bool> canGoBack() async {
    return await _webViewController.canGoBack();
  }

  @override
  Future<bool> canGoForward() async {
    return await _webViewController.canGoForward();
  }

  @override
  Future<void> clearCache() async {
    await _webViewController.clearCache();
    await _webViewController.clearLocalStorage();
  }
}
