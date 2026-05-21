import 'dart:js_interop';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

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
  static bool _scriptLoaded = false;
  late final String _viewType;
  web.EventListener? _listener;
  void _handleTurnstileEvent(web.Event event) {
    if (event is web.CustomEvent) {
      final detail = event.detail;
      final token = detail == null ? '' : detail.toString();
      if (token.isNotEmpty) {
        widget.onToken(token);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _viewType = 'turnstile-${DateTime.now().microsecondsSinceEpoch}';
    _registerView();
    _attachListener();
  }

  void _registerView() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final container = web.HTMLDivElement()
        ..id = 'turnstile-$viewId'
        ..style.width = '100%'
        ..style.height = '120px';

      _injectTurnstile(container.id);
      return container;
    });
  }

  void _injectTurnstile(String elementId) {
    if (!_scriptLoaded) {
      final script = web.HTMLScriptElement()
        ..id = 'turnstile-script'
        ..src =
            'https://challenges.cloudflare.com/turnstile/v0/api.js?onload=turnstileOnload&render=explicit'
        ..async = true
        ..defer = true;
      web.document.head?.append(script);
      _scriptLoaded = true;
    }

    final callbackScript = web.HTMLScriptElement()
      ..text = '''
        window.turnstileOnload = function() {
          if (window.turnstile) {
            window.turnstile.render("#$elementId", {
              sitekey: "${widget.siteKey}",
              callback: function(token) {
                window.dispatchEvent(new CustomEvent("turnstile-token", { detail: token }));
              }
            });
          }
        };
        if (window.turnstile) {
          window.turnstile.render("#$elementId", {
            sitekey: "${widget.siteKey}",
            callback: function(token) {
              window.dispatchEvent(new CustomEvent("turnstile-token", { detail: token }));
            }
          });
        }
      ''';
    web.document.body?.append(callbackScript);
  }

  void _attachListener() {
    _listener = _handleTurnstileEvent.toJS;
    web.window.addEventListener('turnstile-token', _listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      web.window.removeEventListener('turnstile-token', _listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
