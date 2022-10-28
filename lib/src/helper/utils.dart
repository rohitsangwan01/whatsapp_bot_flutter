// get QrCode
import 'dart:async';
import 'package:puppeteer/puppeteer.dart';
import 'dart:developer' as developer;

///[getQrCode] will look for QrCode on Loop , in given time interval
Future<String?> getQrCode({
  required Page page,
  Function(int)? progress,
  int waitDurationSeconds = 5,
}) async {
  // try to get QrCode for Few Seconds
  Completer<String?> completer = Completer();
  // ignore: unused_local_variable
  late Timer timer;
  double availableTick = (waitDurationSeconds * 1000) / 100;
  // A Timer to check for QrCode for 3Seconds , and if no QrCode then Returns Null
  timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
    double currentProgress = (timer.tick / availableTick) * 100;
    progress?.call(currentProgress.toInt());
    if (timer.tick > availableTick) {
      timer.cancel();
      progress?.call(100);
      if (!completer.isCompleted) completer.complete(null);
      return;
    }
    try {
      String? qrCode = await page.evaluate(
        '() => document.querySelector("div[data-ref]").getAttribute("data-ref")',
      );
      if (qrCode != null) {
        timer.cancel();
        progress?.call(100);
        if (!completer.isCompleted) completer.complete(qrCode);
      }
    } catch (e) {
      // ignore for now
    }
  });
  return completer.future;
}

class WhatsappLogger {
  static bool enableLogger = false;

  static void log(log) {
    if (!enableLogger) return;
    developer.log(log.toString(), name: 'WhatsappBotFlutter');
  }
}
