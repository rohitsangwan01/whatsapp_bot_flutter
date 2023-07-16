# Whatsapp bot flutter web

Run Whatsapp bot on web natively

## Getting Started

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
WhatsappClient? whatsappClient = await WhatsappBotFlutterWeb.connect();
```

## TODO

Add more docs and make it stable