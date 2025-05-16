import 'package:flutter/material.dart';

/// A custom text widget that wraps and truncates text dynamically based on pixel width and height constraints.
///
/// Unlike [Text], this widget:
/// - Wraps text at pixel boundaries (not word or character boundaries)
/// - Automatically truncates with ellipsis if the text exceeds the space
/// - Calculates the final visible text at build time using [TextPainter]
///
/// The result is a [Text]-like widget that fits tightly into its layout constraints.
///
/// This widget is useful when you need:
/// - Highly constrained layouts (e.g., dashboards, cards)
/// - Pixel-perfect control over text rendering
/// - Automatic maxLines calculation based on height
///
/// Example usage:
/// ```dart
/// AutoWrapEllipsisText(
///   'This is a long piece of text that will wrap and truncate as needed',
///   style: TextStyle(fontSize: 16),
/// )
/// ```
class AutoWrapEllipsisText extends StatelessWidget {
  /// The text to render.
  final String text;

  /// The style to use for the text. If null, [DefaultTextStyle.of] is used.
  final TextStyle? style;

  /// Controls how the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The type of overflow handling. Defaults to [TextOverflow.ellipsis].
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Maximum number of lines to show before truncating.
  /// If null, it is calculated automatically based on available height.
  final int? maxLines;

  /// The locale used to select region-specific glyphs.
  final Locale? locale;

  /// The text direction. If null, uses ambient [Directionality].
  final TextDirection? textDirection;

  /// Defines how strut is applied to the text.
  final StrutStyle? strutStyle;

  /// Controls the scaling of text.
  final TextScaler? textScaler;

  /// Defines how the width of the text should be measured.
  final TextWidthBasis? textWidthBasis;

  /// Configures the height behavior of the text.
  final TextHeightBehavior? textHeightBehavior;

  /// A semantic label for accessibility.
  final String? semanticsLabel;

  /// The background color when text is selected.
  final Color? selectionColor;

  /// Creates a widget that automatically wraps and truncates text with ellipsis.
  const AutoWrapEllipsisText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveStyle =
        style ?? DefaultTextStyle.of(context).style;
    final _CachedCharWidth charWidthCache = _CachedCharWidth(
      effectiveStyle,
      textDirection ?? TextDirection.ltr,
    );

    final double fontSize = effectiveStyle.fontSize!;
    final double lineHeight = effectiveStyle.height ?? 1.0;
    final double pixelLineHeight = fontSize * lineHeight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final int effectiveMaxLines =
            maxLines ?? (constraints.maxHeight / pixelLineHeight).floor();

        if (effectiveMaxLines < 1) return const SizedBox.shrink();

        final double letterMaxWidth = charWidthCache.getMaxCharWidth(text);
        if (letterMaxWidth > constraints.maxWidth) {
          return const SizedBox.shrink();
        }

        final String wrapped =
            _wrapText(text, constraints.maxWidth, charWidthCache);
        final String fitted = _applyEllipsis(
          wrapped,
          constraints.maxWidth,
          effectiveStyle,
          effectiveMaxLines,
          textDirection ?? TextDirection.ltr,
        );

        return Text(
          fitted,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          overflow: overflow,
          softWrap: softWrap,
          textScaler: textScaler,
          maxLines: effectiveMaxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
        );
      },
    );
  }

  /// Wraps the [text] manually at the pixel level, based on [maxWidth].
  String _wrapText(String text, double maxWidth, _CachedCharWidth widthCache) {
    final buffer = StringBuffer();
    double lineWidth = 0;
    bool isFirstChar = true;

    for (final char in text.characters) {
      final width = widthCache[char];

      if (!isFirstChar && lineWidth + width > maxWidth) {
        buffer.write('\n');
        lineWidth = width;
      } else {
        lineWidth += width;
      }

      buffer.write(char);
      isFirstChar = false;
    }

    return buffer.toString();
  }

  /// Applies binary search to find the maximum number of characters that fit
  /// within the specified number of lines and width, then appends ellipsis.
  String _applyEllipsis(
    String text,
    double maxWidth,
    TextStyle style,
    int maxLines,
    TextDirection direction,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: direction,
      maxLines: maxLines,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth);

    if (!painter.didExceedMaxLines) return text;

    int left = 0;
    int right = text.characters.length;
    String result = '';

    while (left < right) {
      final mid = (left + right) ~/ 2;
      final candidate = '${text.characters.take(mid)}…';

      painter.text = TextSpan(text: candidate, style: style);
      painter.layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines) {
        right = mid;
      } else {
        result = candidate;
        left = mid + 1;
      }
    }

    return result;
  }
}

/// Utility class that caches the width of individual characters for performance.
class _CachedCharWidth {
  final Map<String, double> _cache = {};
  final TextStyle style;
  final TextDirection direction;

  _CachedCharWidth(this.style, this.direction);

  /// Returns the width of a given [char], using a cache to avoid repeated measurement.
  double operator [](String char) {
    return _cache.putIfAbsent(char, () {
      final tp = TextPainter(
        text: TextSpan(text: char, style: style),
        textDirection: direction,
      )..layout();
      return tp.width;
    });
  }

  /// Returns the maximum character width within the given [text].
  double getMaxCharWidth(String text) {
    double max = 0;
    for (final char in text.characters) {
      final w = this[char];
      if (w > max) max = w;
    }
    return max;
  }
}
