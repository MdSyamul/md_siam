import 'dart:js_interop';

@JS('window.open')
external JSAny? _windowOpen(JSString url, JSString target, JSString features);

void openExternal(String url, {String target = '_blank'}) {
  final uri = Uri.tryParse(url);
  if (uri == null || !_isAllowedExternalScheme(uri)) {
    return;
  }

  _windowOpen(url.toJS, target.toJS, 'noopener,noreferrer'.toJS);
}

bool _isAllowedExternalScheme(Uri uri) {
  return switch (uri.scheme.toLowerCase()) {
    'https' || 'http' || 'mailto' || 'tel' => true,
    _ => false,
  };
}
