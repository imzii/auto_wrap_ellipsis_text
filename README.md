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
