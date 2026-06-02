import 'dart:js_interop';

@JS('window.open')
external JSAny? _windowOpen(JSString url, JSString target, JSString features);

@JS('window.downloadFile')
external JSAny? _downloadFile(JSString url, JSString fileName);

void openExternal(String url, {String target = '_blank'}) {
  final uri = Uri.tryParse(url);
  if (uri == null || !_isAllowedExternalScheme(uri)) {
    return;
  }

  _windowOpen(url.toJS, target.toJS, 'noopener,noreferrer'.toJS);
}

void downloadFile(String url, {String fileName = ''}) {
  final uri = Uri.tryParse(url);
  if (uri == null || !_isAllowedDownloadScheme(uri)) {
    return;
  }

  _downloadFile(url.toJS, fileName.toJS);
}

bool _isAllowedExternalScheme(Uri uri) {
  return switch (uri.scheme.toLowerCase()) {
    'https' || 'http' || 'mailto' || 'tel' => true,
    _ => false,
  };
}

bool _isAllowedDownloadScheme(Uri uri) {
  return switch (uri.scheme.toLowerCase()) {
    'https' || 'http' => true,
    _ => false,
  };
}
