import 'dart:io';

import 'package:hive/hive.dart';

class LocalStorage {
  Box? _box;
  String _browserPidKey = 'browserPid';
  String _wsEndPointKey = 'wsEndPoint';

  Future<void> init({bool resetData = false}) async {
    var path = Directory.current.path;
    Hive.init(path);
    _box = await Hive.openBox('botBox');
    if (resetData) await _box?.clear();
  }

  int? get pid => _box?.get(_browserPidKey);
  set pid(value) => _box?.put(_browserPidKey, value);

  String? get wsEndPoint => _box?.get(_wsEndPointKey);
  set wsEndPoint(value) => _box?.put(_wsEndPointKey, value);

  Future<void> closePreviousBrowserInstance() async {
    // Close previous browser if any
    if (pid != null) {
      try {
        await Process.killPid(pid!);
      } catch (_) {}
      pid = null;
    }
  }
}
