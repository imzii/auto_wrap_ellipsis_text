# AutoWrapEllipsisText

`AutoWrapEllipsisText` is a Flutter widget that automatically wraps and truncates text based on pixel constraints.  
It allows you to render dynamic text in tightly constrained spaces with precise control over wrapping and overflow.

Ideal for dashboards, cards, or any layout where text must fit within strict size limits.

---

## Features

- ✅ Auto-wraps text based on pixel width (not just word boundaries)
- ✂️ Truncates with ellipsis when text exceeds height or width
- 🧠 Automatically calculates `maxLines` if not specified
- ⚡️ Performance-optimized with internal character-width caching
- 🎯 Compatible with all standard `Text` widget properties:
  - `style`, `maxLines`, `overflow`, `textAlign`, `softWrap`, `textDirection`, etc.

---

## Getting started

To use this package, ensure you have Flutter 3.13 or later installed.

Add to your `pubspec.yaml`:

```yaml
dependencies:
  auto_wrap_ellipsis_text: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

Here’s a quick example:

```dart
import 'package:auto_wrap_ellipsis_text/auto_wrap_ellipsis_text.dart';

AutoWrapEllipsisText(
  'This is a long piece of text that wraps and truncates as needed',
  style: TextStyle(fontSize: 14),
  maxLines: 2,
  textAlign: TextAlign.center,
);
```

For more, check the /example folder.

---

## Additional information

- This widget internally uses TextPainter to measure character widths and fit text within layout bounds.
- If the container is too small to render even a single character, it returns SizedBox.shrink().

---

## Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the issues page.

To contribute:

1. Fork this repo
2. Create your feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a pull request
