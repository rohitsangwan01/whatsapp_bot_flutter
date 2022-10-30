import 'dart:async';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_chat.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_service.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'model/whatsapp_file_type.dart';

/// [PuppeteerService] for maintaining a single  `Browser` and `Page` instance
/// with methods like connect and send
class PuppeteerService {
  Page? _page;
  Browser? _browser;
  Timer? mainCardTimer;

  // Wpp Classes
  final wppEvents = WppEvents();
  final _wpp = Wpp();
  final _wppAuth = WppAuth();
  final _wppChat = WppChat();

  /// [connectAndLogin] method will open WhatsappWeb in headless webView and connect to the whatsapp
  /// and pass QrCode in `onQrCode` callback
  /// Scan this code , and on successful connection we will get onSuccessCallback
  Future<void> connect({
    String? sessionDirectory,
    bool? headless = true,
    String? browserWsEndpoint,
    Function(String)? onQrCode,
    Function(String)? onError,
    Function()? onSuccess,
    Duration? connectionTimeout = const Duration(seconds: 20),
    Function(int)? progress,
  }) async {
    try {
      // Setup a logger if you want to see the raw chrome protocol
      mainCardTimer?.cancel();
      int currentProgress = 0;
      WhatsappLogger.log("checking/downloading chromium");

      // connect through browserWsEndpoint if available
      if (browserWsEndpoint != null) {
        currentProgress = currentProgress + 5;
        progress?.call(currentProgress);

        _browser = await puppeteer.connect(
          browserWsEndpoint: browserWsEndpoint,
        );
      }
      // if noEndPoint given , connect through chrome launch ,
      // this will not work on Web
      else {
        currentProgress = currentProgress + 2;
        progress?.call(currentProgress);
        RevisionInfo revisionInfo = await downloadChrome(
          cachePath: "./.local-chromium",
        );
        String executablePath = revisionInfo.executablePath;

        WhatsappLogger.log("Got Chromium , opening browser");

        currentProgress = currentProgress + 3;
        progress?.call(currentProgress);

        _browser = await puppeteer.launch(
          headless: headless,
          executablePath: executablePath,
          noSandboxFlag: true,
          args: ['--start-maximized', '--disable-setuid-sandbox'],
          userDataDir: sessionDirectory,
        );
      }

      // Load Whatsapp in Chrome
      currentProgress = currentProgress + 5;
      progress?.call(currentProgress);
      _page = await _browser?.newPage();
      await _page?.setUserAgent(WhatsAppMetadata.userAgent);

      currentProgress = currentProgress + 10;
      progress?.call(currentProgress);

      WhatsappLogger.log("Opening Whatsapp page");
      await _page?.goto(WhatsAppMetadata.whatsAppURL);

      currentProgress = currentProgress + 10;
      progress?.call(currentProgress);

      // Try Auth
      Page page = _page!;
      // initialize wpp first
      await _wpp.init(_page!);

      WhatsappLogger.log("Checking for qrCode");
      String? qrCode = await getQrCode(
          page: page,
          progress: (int prg) {
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

      WhatsappLogger.log("waiting for opening main whatsapp dashboard");

      ElementHandle? mainPanel = await _page?.waitForSelector(
        WhatsAppMetadata.mainPanel,
        timeout: connectionTimeout ?? const Duration(seconds: 20),
      );
      mainCardTimer?.cancel();

      progress?.call(90);
      if (mainPanel == null) {
        onError?.call("Failed to Connect");
        dispose();
      } else {
        onSuccess?.call();
      }
      WhatsappLogger.log("Connected to whatsapp successfully");
      progress?.call(100);

      await _wpp.init(_page!);
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

  void dispose() async {
    try {
      if (_page != null) {
        await _wppAuth.logout(_page!);
      }
      _browser?.close();
      _browser = null;
      _page = null;
    } catch (e) {
      WhatsappLogger.log(e.toString());
    }
  }

  /// open Whatsapp and send message
  /// [sendMessage] may throw errors if contents not loaded on time
  /// or if this method completed without any issue , they probably message sent successfully
  /// `progress` callback will give update for the message sending progress
  Future<void> sendTextMessage({
    required String countryCode,
    required String phone,
    required String message,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    await _wppChat.sendTextMessage(page, phoneNum, message);
  }

  Future<void> sendFileMessage({
    required String countryCode,
    required String phone,
    required WhatsappFileType fileType,
    required List<int> fileBytes,
    String? caption,
    String? mimetype,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    await _wppChat.sendFileMessage(page, phoneNum, fileBytes, fileType,
        caption: caption, mimetype: mimetype);
  }

  Future<void> sendLocationMessage({
    required String phone,
    required String countryCode,
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    await _wppChat.sendLocationMessage(
      page,
      phoneNum,
      lat: lat,
      long: long,
      address: address,
      name: name,
      url: url,
    );
  }

  /// [validateMessage] will verify if data passed is correct or not
  Future<Page> _validateMessage(countryCode, String phone) async {
    Page? page = _page;
    if (page == null) {
      throw WhatsappException(
          message: "Whatsapp not connected yet , please connect first",
          exceptionType: WhatsappExceptionType.clientNotConnected);
    }

    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";

    bool isAuthenticated = await _wppAuth.isAuthenticated(page);
    if (!isAuthenticated) {
      throw WhatsappException(
          message: "Please login first",
          exceptionType: WhatsappExceptionType.unAuthorized);
    }

    // bool isValid = await _wpp.isValidContact(page, phoneNum);
    // if (!isValid) {
    //   throw WhatsappException(
    //       message: "Invalid contact number",
    //       exceptionType: WhatsappExceptionType.inValidContact);
    // }
    return page;
  }
}

class WhatsAppMetadata {
  static String whatsAppURL = "https://web.whatsapp.com/";
  static String mainPanel = "#pane-side";
  static String userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.39 Safari/537.36';
}
