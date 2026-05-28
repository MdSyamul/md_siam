import 'dart:js_interop';

@JS('window.open')
external JSAny? _windowOpen(JSString url, JSString target);

@JS('window.downloadFile')
external JSAny? _downloadFile(JSString url, JSString fileName);

void openExternal(String url, {String target = '_blank'}) {
  _windowOpen(url.toJS, target.toJS);
}

void downloadFile(String url, {String fileName = ''}) {
  _downloadFile(url.toJS, fileName.toJS);
}
