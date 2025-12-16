import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MomoWebView extends StatefulWidget {
  final String paymentUrl;
  final Function(String)? onPaymentSuccess;
  final Function(String)? onPaymentFailed;

  const MomoWebView({
    super.key,
    required this.paymentUrl,
    this.onPaymentSuccess,
    this.onPaymentFailed,
  });

  @override
  State<MomoWebView> createState() => _MomoWebViewState();
}

class _MomoWebViewState extends State<MomoWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            final url = request.url;

            // Xử lý callback URL từ MoMo
            if (url.contains('payment/success') ||
                url.contains('resultCode=0')) {
              widget.onPaymentSuccess?.call(url);
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            }

            if (url.contains('payment/failed') ||
                (url.contains('resultCode=') &&
                    !url.contains('resultCode=0'))) {
              widget.onPaymentFailed?.call(url);
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }

            // Xử lý deep link mở app MoMo
            if (url.startsWith('momo://')) {
              _openMomoApp(url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _openMomoApp(String url) async {
    // TODO: Thêm url_launcher để mở app MoMo
    // await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    debugPrint('Open MoMo app: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán MoMo'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
