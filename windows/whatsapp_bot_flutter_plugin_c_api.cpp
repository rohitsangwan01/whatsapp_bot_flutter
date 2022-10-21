#include "include/whatsapp_bot_flutter/whatsapp_bot_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "whatsapp_bot_flutter_plugin.h"

void WhatsappBotFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  whatsapp_bot_flutter::WhatsappBotFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
