class WebViewState {
  final bool isLoading;
  final bool hasError;
  final String? error;
  final String currentUrl;
  final bool canGoBack;
  final bool canGoForward;

  const WebViewState({
    this.isLoading = false,
    this.hasError = false,
    this.error,
    this.currentUrl = '',
    this.canGoBack = false,
    this.canGoForward = false,
  });

  WebViewState copyWith({
    bool? isLoading,
    bool? hasError,
    String? error,
    String? currentUrl,
    bool? canGoBack,
    bool? canGoForward,
  }) {
    return WebViewState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      currentUrl: currentUrl ?? this.currentUrl,
      canGoBack: canGoBack ?? this.canGoBack,
      canGoForward: canGoForward ?? this.canGoForward,
    );
  }
}
