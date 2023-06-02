# Whatsapp bot flutter Web

Demo of web app built using Whatsapp_bot_flutter


## Setup WhatsappWeb

Run a puppeteer server and get `browserWsEndpoint`, checkout [this](https://github.com/rohitsangwan01/whatsapp_bot_flutter/blob/main/example/puppeteer_server/main.dart) example

Or we can use [browserless](https://cloud.browserless.io/account/), Create a free account there and get `API_TOKEN` from browserless, and use this url as browserWsEndpoint to connect : `wss://chrome.browserless.io?token=API_TOKEN`