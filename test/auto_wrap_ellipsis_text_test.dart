import 'package:flutter_test/flutter_test.dart';

import 'package:auto_wrap_ellipsis_text/auto_wrap_ellipsis_text.dart';

import 'package:flutter/material.dart';

void main() {
  const testText =
      'This is a long piece of text that should wrap and truncate properly.';

  testWidgets('renders basic text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AutoWrapEllipsisText(
            testText,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );

    expect(find.textContaining('This'), findsOneWidget);
  });

  testWidgets('honors maxLines constraint', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 40, // Enough for ~2 lines
            child: AutoWrapEllipsisText(
              testText,
              style: TextStyle(fontSize: 14, height: 1.0),
              maxLines: 2,
            ),
          ),
        ),
      ),
    );

    final richText = tester.widget<RichText>(find.byType(RichText));
    expect(richText.maxLines, 2);
  });

  testWidgets('returns empty widget for too small space',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 5,
              height: 5,
              child: AutoWrapEllipsisText(
                testText,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsExactly(2));
    expect(tester.widget<SizedBox>(find.byType(SizedBox).last).height, 0);
  });

  testWidgets('applies textAlign and overflow', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AutoWrapEllipsisText(
            testText,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.textAlign, TextAlign.center);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
