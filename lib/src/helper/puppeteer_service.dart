// ignore_for_file: avoid_print, empty_catches

import 'dart:async';
import 'package:puppeteer/puppeteer.dart';

class PuppeteerService {
  Page? _page;
  Browser? _browser;
  final _delay = const Duration(milliseconds: 500);
  Timer? mainCardTimer;

  /// First Connect to Chromium and login
  Future<void> connectAndLogin({
    String? sessionDirectory,
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
        headless: true,
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

  // open Whatsapp and send message
  Future<void> sendMessage({
    required String countryCode,
    required String phone,
    String message = "TestMessage",
  }) async {
    Page? page = _page;
    if (page == null) {
      throw Exception(
        "Page not connected yet please call , Connect First and Wait for Success callback",
      );
    }

    String number = countryCode + phone;
    await _openContact(page, number, message);

    await Future.delayed(_delay);
    print('Found $number');

    var editor = await page.$$(WhatsAppMetadata.chatBar);
    await editor[1].focus();

    await Future.delayed(_delay);
    page.keyboard.type(message);

    await Future.delayed(_delay);
    await page.click(WhatsAppMetadata.btnSend);
    print('Message sent! :D');
  }

  // make sure to pass number with country code
  Future<bool> _openContact(Page page, String number, String message) async {
    // first try to find from the list already chatted with
    try {
      // This requires the Person's Name , or Number in the list
      await page.click(WhatsAppMetadata.personObject(number));
      return true;
    } catch (e) {
      // Try another approach
    }

    // then reload new
    try {
      String url = 'https://web.whatsapp.com/send?phone=$number&text=';
      await page.goto(url);

      ElementHandle? editor = await _getChatBoxElement(page);
      await editor?.focus();
      return editor != null;
    } catch (e) {
      // Try another approach
    }

    return false;
  }
}

Future<ElementHandle?> _getChatBoxElement(Page page) async {
  Completer<ElementHandle?> completer = Completer();
// ignore: unused_local_variable
  late Timer timer;
  timer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
    var editor = await page.$$(WhatsAppMetadata.chatBar);
    if (editor.length > 1) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete(editor[1]);
    } else if (timer.tick == 100) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete(null);
    }
  });
  return completer.future;
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
