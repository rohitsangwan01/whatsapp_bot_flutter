# Whatsapp bot flutter

![whatsapp_bot_flutter_logo](https://user-images.githubusercontent.com/59526499/197252923-6c5a1122-91d7-43ea-9283-1cf9d65820fd.png)

[![whatsapp_bot_flutter version](https://img.shields.io/pub/v/whatsapp_bot_flutter?label=whatsapp_bot_flutter)](https://pub.dev/packages/whatsapp_bot_flutter)

Whatsapp bot using whatsapp web scraping

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

## Features

Supported Whatsapp features are :

- Login with QR
- Logout
- Keep session
- Send text message
- Send image, audio & document
- Listen to New Messages
- Listen to Connection Events

## Usage

First connect with whatsapp using ` WhatsappBotFlutter.connect` method , we can get qrcode from `onQrCode` callback
if we got `onSuccess` ,this means we are connected and ready to send messages

To convert qrCode String to QrCode widget for scanning use [pretty_qr_code](https://pub.dev/packages/pretty_qr_code) , check example for more details

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

Use `sendTextMessage` to send a text message

```dart
WhatsappBotFlutter.sendTextMessage(
    countryCode: "91",
    phone: "------",
    message: "Test Message",
);
```

Use `sendFileMessage` to send a File

```dart
await WhatsappBotFlutter.sendFileMessage(
    countryCode: "91",
    phone: "------",
    fileBytes: imageBytes, // Pass a Uint8List file bytes
    caption: "Test Message", // Optional
    fileType: fileType, // document, image, audio
  ;
```

To get new Messages , subscribe to `WhatsappBotFlutter.messageEvents`

```dart
WhatsappBotFlutter.messageEvents.listen((Message message) {
  // Got whatsapp messages ...
});
```

To get whatsapp connection Events , subscribe to `WhatsappBotFlutter.connectionEventStream`

```dart
WhatsappBotFlutter.connectionEventStream.listen((event) {
  // Got Connection Events ...
});
```

## Resources

Thanks to [wa-js](https://github.com/wppconnect-team/wa-js) for exporting functions from WhatsApp Web

## Disclaimer

This project is not affiliated, associated, authorized, endorsed by, or in any way officially connected with WhatsApp or any of its subsidiaries or its affiliates. The official WhatsApp website can be found at https://whatsapp.com. "WhatsApp" as well as related names, marks, emblems and images are registered trademarks of their respective owners.

## Note

Its just initial version , under heavy development
I can't guarantee you will not be blocked by using this method, try to avoid primary whatsapp numbers. WhatsApp does not allow bots or unofficial clients on their platform, so this shouldn't be considered totally safe.
