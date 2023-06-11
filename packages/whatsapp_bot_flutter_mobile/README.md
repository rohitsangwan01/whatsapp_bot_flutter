# Whatsapp bot flutter Mobile

![PicsArt_11-06-01 10 14](https://user-images.githubusercontent.com/59526499/200159656-aa778efd-7947-4c82-998f-2ae0804237a3.png)

[![whatsapp_bot_flutter_mobile version](https://img.shields.io/pub/v/whatsapp_bot_flutter_mobile?label=whatsapp_bot_flutter_mobile)](https://pub.dev/packages/whatsapp_bot_flutter_mobile)

Whatsapp bot using whatsapp web scraping

## Getting Started

This library is for adding Mobile (Android/Ios) support to  [whatsapp_bot_flutter](https://pub.dev/packages/whatsapp_bot_flutter),using [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)

### Android/IOS setup

To setup on Android , make sure to checkout `flutter_inappwebview` setup document for [Android](https://inappwebview.dev/docs/intro#setup-android) and [IOS](https://inappwebview.dev/docs/intro#setup-ios)
Android sdk:minSdkVersion cannot be smaller than version 19

## Usage

First we have to get `WhatsappClient` using `WhatsappBotFlutterMobile.connect` method , we can get qrcode from `onQrCode` callback, this will return a qrString and ImageByte , we can use ImageBytes to show qr as Image widget , or we can convert qrCode String to QrCode widget by any library,

```dart
WhatsappClient? whatsappClient = await WhatsappBotFlutterMobile.connect(
  onConnectionEvent: (ConnectionEvent event) {
    print(event.toString());
  },
  onQrCode: (String qr, Uint8List? imageBytes) {
    // use imageBytes to display in flutter : Image.memory(imageBytes)
  },
);
```
To run on desktop or pure dart projects, checkout complete docs [here](https://github.com/rohitsangwan01/whatsapp_bot_flutter/)

## Resources

Thanks to [wa-js](https://github.com/wppconnect-team/wa-js) for exporting functions from WhatsApp Web

And [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) for Headless WebView

## Disclaimer

This project is not affiliated, associated, authorized, endorsed by, or in any way officially connected with WhatsApp or any of its subsidiaries or its affiliates. The official WhatsApp website can be found at https://whatsapp.com. "WhatsApp" as well as related names, marks, emblems and images are registered trademarks of their respective owners.

## Note

Its just initial version, I can't guarantee you will not be blocked by using this method, try to avoid primary whatsapp numbers. WhatsApp does not allow bots or unofficial clients on their platform, so this shouldn't be considered totally safe.
