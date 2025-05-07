import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo/features/webview/domain/models/webview_state.dart';
import 'package:demo/features/webview/domain/usecases/webview_usecase.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewManager extends StateNotifier<WebViewState> {
  final WebViewUseCase _useCase;

  WebViewManager(this._useCase) : super(const WebViewState());

  WebViewController get webView => _useCase.webViewController;

  Future<void> goBack() async {
    await _useCase.goBack();
    state = state.copyWith(canGoBack: await _useCase.canGoBack());
  }

  Future<void> goForward() async {
    await _useCase.goForward();
    state = state.copyWith(canGoForward: await _useCase.canGoForward());
  }

  Future<void> reload() async {
    await _useCase.reload();
    state = state.copyWith(isLoading: true);
  }

  Future<void> loadUrl(String url) async {
    await _useCase.loadUrl(url);
  }

  @override
  Future<void> dispose() async {
    await _useCase.clearCache();
    super.dispose();
  }
}
