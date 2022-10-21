# Whatsapp bot flutter

[![whatsapp_bot_flutter version](https://img.shields.io/pub/v/whatsapp_bot_flutter?label=whatsapp_bot_flutter)](https://pub.dev/packages/whatsapp_bot_flutter)

Whatsapp bot using whatsapp web scrapping

## Getting Started

First launch will take some time

it will download chromium files locally, using [puppeteer](https://pub.dev/packages/puppeteer) for whatsapp web and scarping data

### Macos setup

Enable outgoing and incoming connections for macos
and also disable sandbox mode comment this out in macos/Runner/\*.entitlements:

```
<key>com.apple.security.app-sandbox</key>
<true/>
```

## Usage

First connect with whatsapp using ` WhatsappBotFlutter.connect` method , we can get qrcode from `onQrCode` callback
if we got `onSuccess` ,this means we are connected and ready to send messages

```dart
WhatsappBotFlutter.connect(
  onQrCode: (String qr) {
    // there we will get QrCode string use any library to convert string to qrcode and scan
  },
  onError: (String er) {
    // listen for errors
  },
  onSuccess: () {
    // if we received this callback , it means we are connected to whatsapp
  },
  progress: (int prg) {
    // we can listen for progress update
  },
);
```

To convert qrCode String to QrCode image use [pretty_qr_code](https://pub.dev/packages/pretty_qr_code)

```dart
PrettyQr(
  size: 300,
  data: qrCodeString,
  roundEdges: true,
),
```

After connection ,use `sendMessage` to send Whatsapp Messages ,

```dart
WhatsappBotFlutter.sendMessage(
    countryCode: "91",
    phone: "------",
    message: "Test Message",
);
```

## Note

Its just initial version , under heavy development
