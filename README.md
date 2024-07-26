# Whatsapp bot flutter

![whatsapp_bot_flutter_logo](https://user-images.githubusercontent.com/59526499/197252923-6c5a1122-91d7-43ea-9283-1cf9d65820fd.png)

[![whatsapp_bot_flutter version](https://img.shields.io/pub/v/whatsapp_bot_flutter?label=whatsapp_bot_flutter)](https://pub.dev/packages/whatsapp_bot_flutter)

[![whatsapp_bot_flutter_mobile version](https://img.shields.io/pub/v/whatsapp_bot_flutter_mobile?label=whatsapp_bot_flutter_mobile)](https://pub.dev/packages/whatsapp_bot_flutter_mobile)

[![whatsapp_bot_flutter_web version](https://img.shields.io/pub/v/whatsapp_bot_flutter_web?label=whatsapp_bot_flutter_web)](https://pub.dev/packages/whatsapp_bot_flutter_web)

## Getting Started

We can use this library in Flutter as well as Pure dart projects , checkout `dart_example`

First launch on Desktop apps will take some time, it will download chromium files locally, using [puppeteer](https://pub.dev/packages/puppeteer)

## Usage

Get `WhatsappClient` using connect method

Either link with QRCode (default) and get QrCode in `onQrCode` callback or set `linkWithPhoneNumber`, and get code in `onPhoneLinkCode` callback

```dart
// use WhatsappBotFlutterMobile.connect for Android/IOS platforms
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

We have these modules to access whatsappClient features :

```dart
WhatsappClient.chat
WhatsappClient.contact
WhatsappClient.profile
WhatsappClient.group
```

Use `sendTextMessage` to send a text message

phone parameter can be of this format : `countryCode+phoneNumber` , eg : `91xxxxxxxxxx` , or we can get phone from messageEvents in this format : `countryCode+phone+"@c.us"`

```dart
await whatsappClient.chat.sendTextMessage(
    phone: "------",
    message: "Test Message",
);
```

Use `sendFileMessage` to send a File

```dart
await whatsappClient.chat.sendFileMessage(
    phone: "------",
    fileBytes: fileBytes, // Pass file bytes
    caption: "Test Message", // Optional
    fileType: fileType, // document, image, audio
);
```

To get whatsapp connection Events , subscribe to `whatsappClient.connectionEventStream`

```dart
whatsappClient.connectionEventStream.listen((event) {
  // Connection Events : authenticated,logout,connected.....
});
```

To get new Messages

```dart
whatsappClient.on(WhatsappEvent.chat_new_message, (data) {
    List<Message> messages = Message.parse(data);
    // replyMessageId  is optional , add this to send a reply message
    whatsappClient.chat.sendTextMessage(
      phone: message.from,
      message: "Hey !",
      replyMessageId: message.id,
    );
});
```

We can listen to multiple events like this

```dart
whatsappClient.on(WhatsappEvent.EVENT_NAME, (data) {})
```

To stop listening to an event

```dart
whatsappClient.off(WhatsappEvent.EVENT_NAME);
```

## Features

<details>
  <summary>Supported Whatsapp features :</summary>
  - Create multiple whatsapp clients
  
  - Login with QR
  - Auto refresh QrCode
  - Logout
  - Keep session
  - Listen to whatsapp events
  - Reject calls
  - Send text message
  - Send image, audio & document
  - Send location message
  - Send poll in groups
  - Send contact card
  - Reply to a message
  - Archive/Unarchive chats
  - Mute/Unmute chat
  - Clear chat
  - Delete chat
  - Get lastSeen
  - Get chats
  - Mark messages as seen
  - Mark message as unread
  - Pin/Unpin chat
  - Delete messages
  - Download media
  - Get messages
  - Get profile picture
  - Get status
  - Get contacts
  - Get status of loggedIn user
  - Set status
  - check if logged in user have business account
  - Set profile picture of logged in user
  - and many more..
</details>

## Mobile Setup (Android/IOS)

To setup on Android , make sure to checkout `flutter_inappwebview` documentation for [Android](https://inappwebview.dev/docs/intro#setup-android) and [IOS](https://inappwebview.dev/docs/intro#setup-ios) setup
Android sdk:minSdkVersion cannot be smaller than version 19

## Desktop setup (Windows/Mac/Linux)

For Macos , Enable outgoing and incoming connections, If getting sandbox issue , try disabling sandbox mode comment this out in macos/Runner/\*.entitlements:

```
<key>com.apple.security.app-sandbox</key>
<true/>
```

Should run out of the box in Windows and Linux

## Web setup

checkout web demo app : https://rohitsangwan01.github.io/whatsapp_bot_flutter

To run natively on Web, checkout [whatsapp_bot_flutter_web](https://pub.dev/packages/whatsapp_bot_flutter_web)

We can use [browserless](https://cloud.browserless.io/account/), Create a free account there and get `API_TOKEN` from browserless, and use this url to connect : `wss://chrome.browserless.io?token=API_TOKEN`

Or we can run [puppeteer](https://pub.dev/packages/puppeteer), and get `browserWsEndpoint` from there and pass into the connect method, checkout [this](https://github.com/rohitsangwan01/whatsapp_bot_flutter/blob/main/example/puppeteer_server/main.dart) example

then pass this `browserWsEndpoint` in connect method, and also requires `wppJsContent`, we can download this file from [here](https://github.com/wppconnect-team/wa-js/releases/latest/download/wppconnect-wa.js), add this file in assets and pass like this,

```dart
await WhatsappBotFlutter.connect(
    browserWsEndpoint: "BROWSER_WS_ENDPOINT_URL",
    wppJsContent: await rootBundle.loadString("assets/wpp.js"),
);
```

We can use this on `Mobile` or `Desktop` platforms as well , to connect to a chrome server hosted somewhere else

If we have to access this webSocket url locally on Mobile or other platforms , we can use [ngrok](https://ngrok.com/) to expose our local Websocket url to internet

## Resources

Thanks to [wa-js](https://github.com/wppconnect-team/wa-js) for exporting functions from WhatsApp Web

## Disclaimer

This project is not affiliated, associated, authorized, endorsed by, or in any way officially connected with WhatsApp or any of its subsidiaries or its affiliates. The official WhatsApp website can be found at https://whatsapp.com. "WhatsApp" as well as related names, marks, emblems and images are registered trademarks of their respective owners.

## Note

Its just initial version, I can't guarantee you will not be blocked by using this method, try to avoid primary whatsapp numbers. WhatsApp does not allow bots or unofficial clients on their platform, so this shouldn't be considered totally safe.
