# Whatsapp bot flutter web

Run Whatsapp bot on web natively (within browser without puppeteer)

## Getting Started

This library is part of [whatsapp_bot_flutter](https://pub.dev/packages/whatsapp_bot_flutter) web implementation

Add this script tag in web/index.html file inside of head tag

```html
<script src="./assets/packages/whatsapp_bot_flutter_web/assets/wp_bot.js" defer></script>
```

Install WhatsappBotFlutter extension on chrome, this extension will insert some required js code in whatsapp web which is required for communication

Install using [scripty](https://scripty.abhisheksatre.com/#/store), 
To install with scripty, open the (link)[(https://scripty.abhisheksatre.com/#/store)] and search for `WhatsappBotFlutterCommunicator` and install it, that's it
this will automatically inject required js in whatsappWeb whenever needed

Or use any extension to inject this code in whatsapp web

```js
const script = document.createElement("script");
script.type = "text/javascript";
script.src = 'https://cdn.jsdelivr.net/gh/rohitsangwan01/whatsapp_bot_flutter_chrome_extension@latest/content.js';
document.body.appendChild(script);
```

Or manually install extension from [here](https://github.com/rohitsangwan01/whatsapp_bot_flutter_chrome_extension)

## Usage

Run project using : `flutter run -d web-server --web-port 8000 --web-hostname 0.0.0.0`, to open in chrome browser where extension is installed

First we have to get `WhatsappClient` using `WhatsappBotFlutterWeb.connect()` method 

```dart
WhatsappClient? whatsappClient = await WhatsappBotFlutterWeb.connect({
  onConnectionEvent: (ConnectionEvent event) {
    print(event.toString());
  },
  onQrCode: (String qr, Uint8List? imageBytes) {
    // use imageBytes to display in flutter : Image.memory(imageBytes)
    print(WhatsappBotFlutter.convertStringToQrCode(qr));
  },
});
```

Check complete docs [here](https://github.com/rohitsangwan01/whatsapp_bot_flutter)

## Resources

Thanks to [wa-js](https://github.com/wppconnect-team/wa-js) for exporting functions from WhatsApp Web

## Disclaimer

This project is not affiliated, associated, authorized, endorsed by, or in any way officially connected with WhatsApp or any of its subsidiaries or its affiliates. The official WhatsApp website can be found at https://whatsapp.com. "WhatsApp" as well as related names, marks, emblems and images are registered trademarks of their respective owners.

## Note

Its just initial version and under development stage, I can't guarantee you will not be blocked by using this method, try to avoid primary whatsapp numbers. WhatsApp does not allow bots or unofficial clients on their platform, so this shouldn't be considered totally safe.
