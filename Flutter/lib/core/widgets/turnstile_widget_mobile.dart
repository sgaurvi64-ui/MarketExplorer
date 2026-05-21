import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TurnstileWidget extends StatefulWidget {
  const TurnstileWidget({
    super.key,
    required this.siteKey,
    required this.onToken,
  });

  final String siteKey;
  final ValueChanged<String> onToken;

  @override
  State<TurnstileWidget> createState() => _TurnstileWidgetState();
}

class _TurnstileWidgetState extends State<TurnstileWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Turnstile',
        onMessageReceived: (message) {
          final token = message.message;
          if (token.isNotEmpty) {
            widget.onToken(token);
          }
        },
      )
      ..loadHtmlString(_buildHtml(widget.siteKey));
  }

  String _buildHtml(String siteKey) {
    return '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
    <style>
      body { margin: 0; padding: 0; background: transparent; }
      .wrapper { display: flex; align-items: center; justify-content: center; height: 120px; }
    </style>
    <script>
      function onTurnstileSuccess(token) {
        Turnstile.postMessage(token);
      }
    </script>
  </head>
  <body>
    <div class="wrapper">
      <div class="cf-turnstile" data-sitekey="$siteKey" data-callback="onTurnstileSuccess"></div>
    </div>
  </body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: WebViewWidget(controller: _controller),
    );
  }
}
