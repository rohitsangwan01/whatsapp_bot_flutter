import 'dart:developer' as developer;

class WhatsappLogger {
  static bool enableLogger = false;

  static void log(log) {
    if (!enableLogger) return;
    developer.log(log.toString(), name: 'WhatsappBotFlutter');
  }
}

class WhatsAppMetadata {
  static String whatsAppURL = "https://web.whatsapp.com/";
  static String mainPanel = "#pane-side";
  static String userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.39 Safari/537.36';
}
