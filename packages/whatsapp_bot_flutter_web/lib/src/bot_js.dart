// ignore_for_file: non_constant_identifier_names,avoid_web_libraries_in_flutter

@JS()
library bot_js;

import 'dart:js_util';
import 'package:js/js.dart';

external void connect(onConnect, onWebPackReady);

external Future dispose();

Future evaluateJsCodeWithPromise(String code, bool tryPromise) {
  return promiseToFuture(evaluateJs(code, tryPromise));
}

external setTabConnectionListener(tabId, callback);

Future isConnectedWithPromise(String tabId) {
  return promiseToFuture(isConnected(tabId));
}

external isConnected(tabId);

external getAllChildTabs();

external evaluateJs(String code, bool tryPromise);

external setEvent(eventName, callback);

JsCallback<T>(Function(T) callback) => allowInterop(callback);
JsVoidCallback(Function() callback) => allowInterop(callback);
