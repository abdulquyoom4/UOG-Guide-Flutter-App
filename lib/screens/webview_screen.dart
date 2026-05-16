import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  final String url;

  // Optional auto-scroll selector
  final String? scrollSelector;

  // Optional pixel scroll
  final double? scrollPosition;

  const WebViewScreen({
    super.key,
    required this.url,
    this.scrollSelector,
    this.scrollPosition,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen>
    with AutomaticKeepAliveClientMixin {

  late final WebViewController _controller;

  final ValueNotifier<double> _progressNotifier =
  ValueNotifier<double>(0);

  final ValueNotifier<bool> _loadingNotifier =
  ValueNotifier<bool>(true);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebViewPlatform.instance;
    }

    _controller = WebViewController()

      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      ..enableZoom(false)

      ..setBackgroundColor(Colors.white)

      ..setNavigationDelegate(
        NavigationDelegate(

          onPageStarted: (_) {
            _loadingNotifier.value = true;
          },

          onProgress: (progress) {
            final value = progress / 100;

            if ((value - _progressNotifier.value).abs() > 0.15 ||
                value == 1.0) {
              _progressNotifier.value = value;
            }
          },

          onPageFinished: (_) async {

            _progressNotifier.value = 1.0;

            // ============================
            // SMOOTH SCROLL (IMPROVED)
            // ============================
            if (widget.scrollSelector != null) {

              final selector = widget.scrollSelector;

              await _controller.runJavaScript('''
                function smoothScrollToTarget() {

                  const el = document.querySelector("$selector");

                  if (!el) return;

                  const startPos = window.pageYOffset;
                  const target = el.getBoundingClientRect().top + startPos;
                  const distance = target - startPos;

                  let start = null;
                  const duration = 650;

                  function step(timestamp) {
                    if (!start) start = timestamp;

                    const progress = timestamp - start;
                    const percent = Math.min(progress / duration, 1);

                    const ease = percent < 0.5
                      ? 2 * percent * percent
                      : -1 + (4 - 2 * percent) * percent;

                    window.scrollTo(0, startPos + distance * ease);

                    if (progress < duration) {
                      requestAnimationFrame(step);
                    }
                  }

                  requestAnimationFrame(step);
                }

                requestAnimationFrame(() => {
                  setTimeout(smoothScrollToTarget, 50);
                });
              ''');
            }

            // Pixel scroll fallback
            else if (widget.scrollPosition != null) {

              await _controller.runJavaScript('''
                window.scrollTo({
                  top: ${widget.scrollPosition},
                  behavior: "smooth"
                });
              ''');
            }

            _loadingNotifier.value = false;
          },

          onWebResourceError: (_) {
            _loadingNotifier.value = false;
          },
        ),
      )

      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _progressNotifier.dispose();
    _loadingNotifier.dispose();
    super.dispose();
  }

  String get _title {
    return widget.url
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .replaceAll('www.', '');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PopScope(

      canPop: false,

      onPopInvokedWithResult: (didPop, result) async {

        if (didPop) return;

        // System back button/navigation goes back one page in history
        if (await _controller.canGoBack()) {
          await _controller.goBack();
        } else {
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },

      child: Scaffold(

        appBar: AppBar(

          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // Top arrow always returns to the app
            onPressed: () {
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),

          title: Text(
            _title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),

          actions: [

            IconButton(
              icon: const Icon(Icons.refresh_sharp),
              onPressed: _controller.reload,
            ),
          ],

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),

            child: ValueListenableBuilder<double>(
              valueListenable: _progressNotifier,

              builder: (_, value, __) {

                if (value >= 1.0) {
                  return const SizedBox.shrink();
                }

                return LinearProgressIndicator(
                  value: value == 0 ? null : value,
                );
              },
            ),
          ),
        ),

        body: Stack(
          children: [

            RepaintBoundary(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),

            ValueListenableBuilder<bool>(
              valueListenable: _loadingNotifier,

              builder: (_, loading, __) {

                if (!loading) {
                  return const SizedBox.shrink();
                }

                return const IgnorePointer(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
