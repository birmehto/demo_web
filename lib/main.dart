import 'package:demo/features/webview/domain/models/webview_state.dart';
import 'package:demo/features/webview/domain/usecases/webview_usecase.dart';
import 'package:demo/features/webview/presentation/controllers/webview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Stick WebView',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const WebViewScreen(),
    );
  }
}

final webViewManagerProvider =
    StateNotifierProvider<WebViewManager, WebViewState>((ref) {
      return WebViewManager(WebViewUseCase());
    });

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViewManager = ref.watch(webViewManagerProvider.notifier);
    final webViewState = ref.watch(webViewManagerProvider);
    final urlController = TextEditingController(text: webViewState.currentUrl);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: webViewManager.webView),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: TextField(
                controller: urlController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black.withValues(alpha:  0.3),
                  hintText: 'Enter URL',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      webViewManager.loadUrl(urlController.text);
                    },
                  ),
                ),
                onSubmitted: (url) {
                  webViewManager.loadUrl(url);
                },
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed:
                        webViewState.canGoBack
                            ? () => webViewManager.goBack()
                            : null,
                    color: webViewState.canGoBack ? Colors.white : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed:
                        webViewState.canGoForward
                            ? () => webViewManager.goForward()
                            : null,
                    color:
                        webViewState.canGoForward ? Colors.white : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => webViewManager.reload(),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            if (webViewState.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (webViewState.hasError)
              Center(
                child: Text(
                  webViewState.error ?? 'An error occurred',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
