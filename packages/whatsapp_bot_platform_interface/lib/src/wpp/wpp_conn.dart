import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppConn {
  WpClientInterface wpClient;
  WppConn(this.wpClient);

  /// Set keep alive state, that will force the focused and online state
  Future setAlive([bool value = true]) async {
    var aliveValue = value ? '' : false;
    return await wpClient.evaluateJs(
      '''WPP.conn.setKeepAlive($aliveValue);''',
      methodName: "setAlive",
    );
  }

  /// Check if whatsapp web is asking for update
  Future needsUpdate() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.needsUpdate();''',
      methodName: "needsUpdate",
    );
  }

  /// Check is online
  Future isOnline() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.isOnline();''',
      methodName: "isOnline",
    );
  }

  /// Return the current logged user ID with device id
  Future getMyDeviceId() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.getMyDeviceId();''',
      methodName: "getMyDeviceId",
    );
  }

  /// Return the current logged user ID without device id
  Future getMyUserId() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.getMyUserId();''',
      methodName: "getMyUserId",
    );
  }

  /// Set the online state to online
  Future markAvailable() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.markAvailable();''',
      methodName: "markAvailable",
    );
  }

  /// Check is the current browser is logged before loading
  Future isRegistered() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.isRegistered();''',
      methodName: "isRegistered",
    );
  }

  /// Check if multiDevice
  Future isMultiDevice() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.isMultiDevice();''',
      methodName: "isRegistered",
    );
  }

  /// Check if idel
  Future isIdle() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.isIdle();''',
      methodName: "isIdle",
    );
  }

  /// Check if main is initialized
  Future isMainInit() async {
    return await wpClient.evaluateJs(
      '''WPP.conn.isMainInit();''',
      methodName: "isMainInit",
    );
  }
}
