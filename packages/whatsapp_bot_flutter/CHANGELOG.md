## 2.1.1

- Bump whatsapp_bot_platform_interface to 2.0.1

## 2.1.0

- Bump whatsapp_bot_platform_interface to 2.0.0

## 2.0.4

- Bump whatsapp_bot_platform_interface

## 2.0.2

- fix downloadMedia

## 2.0.1

- add wpClient.conn
- add few group methods
- fix getChat,getMessages, getContacts
- minor fixes

## 2.0.0

- update to whatsapp_bot_platform_interface 1.0.0
- Breaking change: new way of listening to messages: client.on(WhatsappEvent.chat_new_message, (data) => print(data));
- add support for listening to multiple events
- fix delete message
- add option to send file name in sendFileMessage
- add more methods to WhatsappClient.chat

## 1.0.0

- use whatsapp_bot_platform_interface
- improved docs
- added proper pure dart implementation
- extracted mobile support into another package

## 0.1.1

- update to dart3
- fix web
- switch to flutter_inappwebview stable version

## 0.0.10

- Implemented dart only in pubspec
- minor bug fixes
- added option to send buttons with messages
- fix quotes in text messages

## 0.0.9

- Updated platforms
- Updated Example app
- Updated Readme

## 0.0.8

- Added support for native Android and Ios
- Added WhatsappBotFlutterMobile.connect method to connect in native Mobile platforms
- Minor bug fixes
- Update readme

## 0.0.7

- Added support for Android and Ios
- update readme

## 0.0.6

- breakingChange: we have to use WhatsappClient.chat for accessing sendTextMessage/sendFilesMessages
- Added WhatsappClient.chat With these Features
  - Send Text/File/Location messages
  - Added archive/unarchive chat
  - canMute
  - mute /unmute
  - clearChat
  - deleteChat
  - getLastSeen
  - getChats
  - markAsSeen
  - markAsUnread
  - pin/unpin
  - deleteMessages
  - downloadMedia
  - getMessages
  - createPollInGroups
  - sendContactCard
- Added WhatsappClient.contact with these Features
  - getProfilePicture
  - getStatus
  - getContacts
- Added WhatsappClient.profile with these Features
  - getMyStatus
  - setMyStatus
  - isBusiness
  - setMyProfilePicture

## 0.0.5

- breaking changes
- added multi Client support
- added call events
- added option to reject call
- added option to reply to a message
- added web support
- and many other minor features

## 0.0.4

- remove flutter dependency
- add pureDart support
- add method to convert string to QRCodeText to print in terminal
- minor bug fixes

## 0.0.3

- major refactoring
- added option to share files
- added option to share location
- added option to get messages stream

## 0.0.2

- minor fixes

## 0.0.1

- Initial version
