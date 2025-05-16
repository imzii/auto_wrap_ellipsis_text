import 'package:flutter/material.dart';
import 'package:auto_wrap_ellipsis_text/auto_wrap_ellipsis_text.dart';

void main() {
  runApp(const AutoWrapEllipsisExampleApp());
}

class AutoWrapEllipsisExampleApp extends StatelessWidget {
  const AutoWrapEllipsisExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoWrapEllipsisText Demo',
      home: const AutoWrapEllipsisDemo(),
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}

class AutoWrapEllipsisDemo extends StatelessWidget {
  const AutoWrapEllipsisDemo({super.key});

  final String sampleText =
      'This is a very long line of text that should wrap to fit within the box and get truncated if there is no more space available.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AutoWrapEllipsisText Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                'Below is an AutoWrapEllipsisText inside a constrained box:'),
            const SizedBox(height: 16),
            Container(
              width: 200,
              height: 60,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(8),
              child: AutoWrapEllipsisText(
                sampleText,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 32),
            const Text('Example with a custom maxLines:'),
            const SizedBox(height: 16),
            Container(
              width: 300,
              height: 50,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(8),
              child: AutoWrapEllipsisText(
                sampleText,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
