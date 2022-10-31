import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/login_helper.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/qr_code_image.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:zxing2/qrcode.dart';

/// [WhatsappBotFlutter] for maintaining a single  `Browser` and `Page` instance
/// with methods like connect and send
class WhatsappBotFlutter {
  static Page? _page;
  static Browser? _browser;

  /// [connectionEventStream] will give update of Connection Events
  static Stream<ConnectionEvent> connectionEventStream =
      WppEvents.connectionEventStreamController.stream;

  ///[messageEvents] will give update of all new messages
  static Stream<Message> messageEvents =
      WppEvents.messageEventStreamController.stream;

  /// [connect] method will open WhatsappWeb in headless webView and connect to the whatsapp
  /// and pass QrCode in `onQrCode` callback
  /// Scan this code , and on successful connection we will get onSuccessCallback
  static Future<void> connect({
    String? sessionDirectory,
    String? chromiumDownloadDirectory,
    bool? headless = true,
    String? browserWsEndpoint,
    int qrCodeWaitDurationSeconds = 60,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    Function(String)? onError,
    Function()? onSuccess,
    Duration? connectionTimeout = const Duration(seconds: 20),
  }) async {
    try {
      if (browserWsEndpoint != null) {
        _browser = await puppeteer.connect(
          browserWsEndpoint: browserWsEndpoint,
        );
      } else {
        RevisionInfo revisionInfo = await downloadChrome(
          cachePath: chromiumDownloadDirectory ?? "./.local-chromium",
        );
        String executablePath = revisionInfo.executablePath;
        _browser = await puppeteer.launch(
          headless: headless,
          executablePath: executablePath,
          noSandboxFlag: true,
          args: ['--start-maximized', '--disable-setuid-sandbox'],
          userDataDir: sessionDirectory,
        );
      }

      _page = await _browser?.newPage();
      if (_page == null) {
        onError?.call("Something went wrong !");
        return;
      }

      Page page = _page!;

      await page.setUserAgent(WhatsAppMetadata.userAgent);
      await page.goto(WhatsAppMetadata.whatsAppURL);

      await waitForLogin(
        page,
        (QrCodeImage qrCodeImage, int attempt) {
          if (qrCodeImage.base64Image != null && qrCodeImage.urlCode != null) {
            Uint8List? imageBytes;
            try {
              String? base64Image = qrCodeImage.base64Image
                  ?.replaceFirst("data:image/png;base64,", "");
              imageBytes = base64Decode(base64Image!);
            } catch (e) {
              WhatsappLogger.log(e);
            }
            onQrCode?.call(qrCodeImage.urlCode!, imageBytes);
          }
        },
        waitDurationSeconds: qrCodeWaitDurationSeconds,
      );

      onSuccess?.call();
    } catch (e) {
      WhatsappLogger.log(e.toString());
      onError?.call(e.toString());
      disconnect();
    }
  }

  /// [disconnect] will close the browser instance and set values to null
  static Future<void> disconnect({
    bool tryLogout = false,
  }) async {
    try {
      if (tryLogout) await logout();
      _browser?.close();
      _browser = null;
      _page = null;
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  ///[logout] will try to logout only if We are connected and already logged in
  static Future<void> logout() async {
    try {
      if (_page != null && await WppAuth.isAuthenticated(_page!)) {
        await WppAuth.logout(_page!);
      }
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  /// open Whatsapp and send message
  /// [sendMessage] may throw errors if contents not loaded on time
  /// or if this method completed without any issue , they probably message sent successfully
  /// `progress` callback will give update for the message sending progress
  static Future<void> sendTextMessage({
    required String countryCode,
    required String phone,
    required String message,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    var sendResult = await page.evaluate(
      '''() => WPP.chat.sendTextMessage("$phoneNum", "$message");''',
    );
    WhatsappLogger.log("SendResult : $sendResult");
  }

  static Future<void> sendFileMessage({
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
    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? _getMimeType(fileType);
    String imgData = "data:$mimeType;base64,$base64Image";
    var sendResult = await page
        .evaluate('''(phone,imgData,caption) => WPP.chat.sendFileMessage(
        phone,imgData,
        {
          type: 'image',
          caption: caption
        });''', args: [phoneNum, imgData, caption]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  static Future<void> sendLocationMessage({
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
    var sendResult = await page.evaluate(
        '''(phone,lat,long,address,name,url) => WPP.chat.sendLocationMessage(phone, {
              lat: lat,
              lng: long,
              name: name, 
              address: address,
              url: url 
            });
            ''',
        args: [phoneNum, lat, long, address, name, url]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  /// [validateMessage] will verify if data passed is correct or not
  static Future<Page> _validateMessage(countryCode, String phone) async {
    Page? page = _page;
    if (page == null) {
      throw WhatsappException(
          message: "Whatsapp not connected yet , please connect first",
          exceptionType: WhatsappExceptionType.clientNotConnected);
    }

    countryCode = countryCode.replaceAll("+", "");

    bool isAuthenticated = await WppAuth.isAuthenticated(page);
    if (!isAuthenticated) {
      throw WhatsappException(
          message: "Please login first",
          exceptionType: WhatsappExceptionType.unAuthorized);
    }

    // String phoneNum = "$countryCode$phone@c.us";
    // bool isValid = await _wpp.isValidContact(page, phoneNum);
    // if (!isValid) {
    //   throw WhatsappException(
    //       message: "Invalid contact number",
    //       exceptionType: WhatsappExceptionType.inValidContact);
    // }
    return page;
  }

  /// [convertStringToQrCode] will convert a Text into a qrCode , which we can print in Terminal
  /// used in scanning code from terminal if we are using this in pure Dart project
  /// make sure to run dart project in terminal , not in DebugConsole for proper Qr representation
  static String convertStringToQrCode(String text) {
    var qrcode = Encoder.encode(text, ErrorCorrectionLevel.l);
    var matrix = qrcode.matrix!;
    var stringBuffer = StringBuffer();
    for (var y = 0; y < matrix.height; y += 2) {
      for (var x = 0; x < matrix.width; x++) {
        final y1 = matrix.get(x, y) == 1;
        final y2 = (y + 1 < matrix.height) ? matrix.get(x, y + 1) == 1 : false;

        if (y1 && y2) {
          stringBuffer.write('█');
        } else if (y1) {
          stringBuffer.write('▀');
        } else if (y2) {
          stringBuffer.write('▄');
        } else {
          stringBuffer.write(' ');
        }
      }
      stringBuffer.writeln();
    }
    return stringBuffer.toString();
  }

  /// To print logs from this library
  /// set `enableLogs(true)`
  /// by default its false
  static enableLogs(bool enable) {
    WhatsappLogger.enableLogger = enable;
  }

  /// [_getMimeType] returns default mimeType
  static String _getMimeType(WhatsappFileType fileType) {
    switch (fileType) {
      case WhatsappFileType.document:
        return "application/msword";
      case WhatsappFileType.image:
        return "image/jpeg";
      case WhatsappFileType.audio:
        return "audio/mp3";
      // case WhatsappFileType.video:
      //   return "video/mp4";
    }
  }
}
