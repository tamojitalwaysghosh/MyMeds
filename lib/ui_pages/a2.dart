import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Blogs2Screen extends StatefulWidget {
  const Blogs2Screen({super.key});

  @override
  State<Blogs2Screen> createState() => _Blogs2ScreenState();
}

class _Blogs2ScreenState extends State<Blogs2Screen> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse('https://sm139.github.io/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips for middle aged'),
        backgroundColor: Color(0xFF4e5ae8),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
