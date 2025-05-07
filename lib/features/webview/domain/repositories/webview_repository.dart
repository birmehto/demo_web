abstract class WebViewRepository {
  Future<void> loadUrl(String url);
  Future<void> goBack();
  Future<void> goForward();
  Future<void> reload();
  Future<bool> canGoBack();
  Future<bool> canGoForward();
  Future<void> clearCache();
}
