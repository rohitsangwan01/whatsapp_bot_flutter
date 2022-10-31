# Whatsapp bot flutter

![whatsapp_bot_flutter_logo](https://user-images.githubusercontent.com/59526499/197252923-6c5a1122-91d7-43ea-9283-1cf9d65820fd.png)

[![whatsapp_bot_flutter version](https://img.shields.io/pub/v/whatsapp_bot_flutter?label=whatsapp_bot_flutter)](https://pub.dev/packages/whatsapp_bot_flutter)

Whatsapp bot using whatsapp web scraping

## Getting Started

We can use this library in Flutter as well as Pure dart projects , checkout dart [example](https://github.com/rohitsangwan01/whatsapp_bot_flutter/blob/main/example_dart/main.dart)

First launch will take some time

it will download chromium files locally, using [puppeteer](https://pub.dev/packages/puppeteer) for whatsapp web and scarping data

## Features

Supported Whatsapp features are :

- create multiple whatsapp clients
- Login with QR
- Auto refresh QrCode
- Logout
- Keep session
- Send text message
- Send image, audio & document
- Send location message
- Reply to a message
- Listen to New Messages
- Listen to Connection Events
- Listen to calls
- Reject calls

### Macos setup

Enable outgoing and incoming connections for macos
and also disable sandbox mode comment this out in macos/Runner/\*.entitlements:

```
<key>com.apple.security.app-sandbox</key>
<true/>
```

### Web setup

To run on web , we have to run a chrome server somewhere using [puppeteer](https://pub.dev/packages/puppeteer), and get `browserWsEndpoint` from there and pass into the connect method

checkout [this](https://github.com/rohitsangwan01/whatsapp_bot_flutter/blob/main/example/puppeteer_server/main.dart) example of running a chrome server using puppeteer

then pass this `browserWsEndpoint` in connect method like this

```dart
await WhatsappBotFlutter.connect( browserWsEndpoint: "BROWSER_WS_ENDPOINT_URL",);
```

We can use this on desktop platforms as well , to connect to a chrome server hosted somewhere else

## Usage

First we have to get `WhatsappClient` using `WhatsappBotFlutter.connect` method , we can get qrcode from `onQrCode` callback, this will return a qrString and ImageByte , we can use ImageBytes to show qr as Image widget , or we can convert qrCode String to QrCode widget by any library,
and to print qrCode in terminal use `WhatsappBotFlutter.convertStringToQrCode(qrString)`

```dart
  WhatsappClient? whatsappClient = await WhatsappBotFlutter.connect(
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      // use imageBytes to display in flutter : Image.memory(imageBytes)
      print(WhatsappBotFlutter.convertStringToQrCode(qr));
    },
  );
```

Use `sendTextMessage` to send a text message

phone parameter can be of this format : `countryCode+phoneNumber` , eg : `91xxxxxxxxxx` , or we can get phone from messageEvents in this format : `countryCode+phone+"@c.us"`

```dart
await whatsappClient.sendTextMessage(
    phone: "------",
    message: "Test Message",
);
```

Use `sendFileMessage` to send a File

```dart
await whatsappClient.sendFileMessage(
    phone: "------",
    fileBytes: fileBytes, // Pass file bytes
    caption: "Test Message", // Optional
    fileType: fileType, // document, image, audio
  ;
```

To get new Messages , subscribe to `whatsappClient.messageEvents`

```dart
whatsappClient.messageEvents.listen((Message message) {
    // replyMessageId  is optional , add this to send a reply message
    client.sendTextMessage(
      phone: message.from,
      message: "Hey !",
      replyMessageId: message.id,
    );
});
```

To get whatsapp connection Events , subscribe to `whatsappClient.connectionEventStream`

```dart
whatsappClient.connectionEventStream.listen((event) {
  // Connection Events : authenticated,logout,connected.....
});
```

To get whatsapp calls Events , subscribe to `whatsappClient.callEvents`

```dart
whatsappClient.callEvents.listen((event) {
  // To reject call
  whatsappClient.rejectCall(callId: event.id);
});
```

## Resources

Thanks to [wa-js](https://github.com/wppconnect-team/wa-js) for exporting functions from WhatsApp Web

## Disclaimer

This project is not affiliated, associated, authorized, endorsed by, or in any way officially connected with WhatsApp or any of its subsidiaries or its affiliates. The official WhatsApp website can be found at https://whatsapp.com. "WhatsApp" as well as related names, marks, emblems and images are registered trademarks of their respective owners.

## Note

Its just initial version , under heavy development

I can't guarantee you will not be blocked by using this method, try to avoid primary whatsapp numbers. WhatsApp does not allow bots or unofficial clients on their platform, so this shouldn't be considered totally safe.
