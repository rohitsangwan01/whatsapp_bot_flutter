# whatsapp_bot
[![win_ble version](https://img.shields.io/pub/v/win_ble?label=win_ble)](https://pub.dev/packages/win_ble)
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

## Note

Its just initial version , under heavy development
