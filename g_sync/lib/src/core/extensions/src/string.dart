part of '../extensions.dart';

extension StringExtGS on String {
  String get snakeCase => replaceAll(" ", "_").toLowerCase();

  /// Checks if the string contains HTML code.
  ///
  /// Returns `true` if HTML tags are detected, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// print('<div>Hello</div>'.containsHtml); // true
  /// print('Hello World'.containsHtml); // false
  /// print('5 < 10 and 10 > 5'.containsHtml); // false
  /// ```
  bool get containsHtml {
    if (isEmpty) return false;

    // Check for common HTML patterns
    final htmlPatterns = [
      RegExp(r'<\s*([a-zA-Z][a-zA-Z0-9]*)\b[^>]*>', caseSensitive: false), // Opening tags
      RegExp(r'<\s*/\s*([a-zA-Z][a-zA-Z0-9]*)\s*>', caseSensitive: false), // Closing tags
      RegExp(r'<\s*br\s*/?\s*>', caseSensitive: false), // Self-closing tags like <br/>
      RegExp(r'<!DOCTYPE\s+html', caseSensitive: false), // DOCTYPE
    ];

    // Check if any pattern matches
    for (final pattern in htmlPatterns) {
      if (pattern.hasMatch(this)) {
        // Additional validation: avoid false positives like "5 < 10"
        if (_looksLikeActualHtml()) {
          return true;
        }
      }
    }

    return false;
  }

  /// Additional check to distinguish HTML from comparison operators
  bool _looksLikeActualHtml() {
    // Common HTML tags
    final commonTags = [
      'div', 'span', 'p', 'a', 'img', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
      'ul', 'ol', 'li', 'table', 'tr', 'td', 'th', 'form', 'input', 'button',
      'header', 'footer', 'nav', 'section', 'article', 'br', 'hr', 'strong',
      'em', 'b', 'i', 'script', 'style', 'link', 'meta', 'title', 'body', 'html'
    ];

    final lowerStr = toLowerCase();
    for (final tag in commonTags) {
      if (lowerStr.contains('<$tag') || lowerStr.contains('</$tag>')) {
        return true;
      }
    }

    // Check for HTML attributes (common sign of HTML)
    if (RegExp(r'<[^>]+\s+(class|id|href|src|style|type|name|value)\s*=').hasMatch(this)) {
      return true;
    }

    return false;
  }
}