// ignore_for_file: avoid_print, empty_catches
// Thanks to : https://github.com/patricknicolosi/whatsapp_sender_flutter

import 'dart:async';
import 'package:puppeteer/puppeteer.dart';

/// [PuppeteerService] for maintaining a single  `Browser` and `Page` instance
/// with methods like connect and send
class PuppeteerService {
  Page? _page;
  Browser? _browser;
  Timer? mainCardTimer;

  /// [connectAndLogin] method will open WhatsappWeb in headless webView and connect to the whatsapp
  /// and pass QrCode in `onQrCode` callback
  /// Scan this code , and on successful connection we will get onSuccessCallback
  Future<void> connectAndLogin({
    String? sessionDirectory,
    bool? headless = true,
    Function(String)? onQrCode,
    Function(String)? onError,
    Function()? onSuccess,
    Duration? connectionTimeout = const Duration(seconds: 20),
    Function(int)? progress,
  }) async {
    try {
      mainCardTimer?.cancel();
      int currentProgress = 0;
      progress?.call(currentProgress);
      _browser = await puppeteer.launch(
        headless: false,
        noSandboxFlag: true,
        args: ['--disable-setuid-sandbox'],
        userDataDir: sessionDirectory,
      );

      currentProgress = currentProgress + 10;
      progress?.call(currentProgress);
      _page = await _browser?.newPage();
      await _page?.setUserAgent(WhatsAppMetadata.userAgent);

      currentProgress = currentProgress + 10;
      progress?.call(currentProgress);

      await _page?.goto(WhatsAppMetadata.whatsAppURL);

      currentProgress = currentProgress + 10;
      progress?.call(currentProgress);

      String? qrCode = await _getQrCode(progress: (int prg) {
        currentProgress = 30 + ((prg / 100) * 30).toInt();
        progress?.call(currentProgress);
      });
      if (qrCode != null) {
        onQrCode?.call(qrCode);
      }

      mainCardTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        int availableSeconds = connectionTimeout?.inSeconds ?? 20;
        if (timer.tick == availableSeconds) {
          mainCardTimer?.cancel();
        }
        double prg = (timer.tick / availableSeconds) * 100;
        currentProgress = 60 + ((prg / 100) * 30).toInt();
        progress?.call(currentProgress.toInt());
      });

      ElementHandle? mainPanel = await _page?.waitForSelector(
        WhatsAppMetadata.mainPanel,
        timeout: connectionTimeout ?? const Duration(seconds: 20),
      );
      mainCardTimer?.cancel();

      progress?.call(90);
      if (mainPanel == null) {
        onError?.call(WhatsappError.connectionFailed);
        dispose();
      } else {
        onSuccess?.call();
      }
      progress?.call(100);
    } catch (e) {
      progress?.call(100);
      mainCardTimer?.cancel();
      if (e.toString().contains("TimeoutException")) {
        onError?.call("Timeout Please Try to connect again");
      } else {
        onError?.call(e.toString());
      }
      dispose();
    }
  }

  void dispose() {
    try {
      _browser?.close();
      _browser = null;
      _page = null;
    } catch (e) {
      print(e.toString());
    }
  }

  // get QrCode
  Future<String?> _getQrCode({
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
        String? qrCode = await _page?.evaluate(
          '() => document.querySelector("div[data-ref]").getAttribute("data-ref")',
        );
        if (qrCode != null) {
          timer.cancel();
          progress?.call(100);
          if (!completer.isCompleted) completer.complete(qrCode);
        }
      } catch (e) {}
    });
    return completer.future;
  }

  /// open Whatsapp and send message
  /// [sendMessage] may throw errors if contents not loaded on time
  /// or if this method completed without any issue , they probably message sent successfully
  /// `progress` callback will give update for the message sending progress
  Future<void> sendMessage({
    required String countryCode,
    required String phone,
    String message = "TestMessage",
    Function(int)? progress,
  }) async {
    try {
      Page? page = _page;
      if (page == null) {
        throw Exception(
            "Page not connected yet please call , Connect First and Wait for Success callback");
      }
      progress?.call(10);
      String url =
          'https://web.whatsapp.com/send?phone=${countryCode + phone}&text=$message';
      print(url);
      await page.goto(url);
      progress?.call(20);
      // TODO : Sometimes stucked if wrong phone number passed
      // try to listen to the error message from the dialog , and respond based on that
      // also close this Dialog Stream on crash or other events
      var onDialog = page.onDialog.listen((event) {
        print(event.message);
        progress?.call(30);
        event.accept();
      }, cancelOnError: true);

      onDialog.onDone(() {
        progress?.call(40);
        onDialog.cancel();
      });

      progress?.call(50);
      await page.waitForSelector("progress",
          hidden: true, timeout: const Duration(milliseconds: 60000));
      progress?.call(70);
      await page.waitForSelector(
          'div:nth-child(2) > button > span[data-icon="send"]',
          timeout: const Duration(milliseconds: 60000));
      progress?.call(90);
      await page.keyboard.press(Key.enter);
      progress?.call(100);
    } catch (e) {
      rethrow;
    }
  }
}

class WhatsAppMetadata {
  static String whatsAppURL = "https://web.whatsapp.com/";
  static String mainPanel = "#pane-side";
  static String personObject(String name) => '[title="$name"]';
  static String chatBar = ".g0rxnol2";
  static String btnSend = "[data-testid='send']";
  static String userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.39 Safari/537.36';
}

class WhatsappError {
  static String connectionFailed = "Failed to Connect";
}
