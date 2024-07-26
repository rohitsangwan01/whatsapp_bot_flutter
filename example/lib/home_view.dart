import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp Bot'),
          centerTitle: false,
          actions: [
            if (GetPlatform.isDesktop) const ConnectDisconnectWidget(),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (GetPlatform.isMobile) const ConnectDisconnectWidget(),

                  // Show Error

                  Obx(() {
                    return controller.error.value.isEmpty
                        ? const SizedBox()
                        : Text(
                            controller.error.value,
                            style: const TextStyle(color: Colors.red),
                          );
                  }),

                  const MiddleFormView(),
                  // Mid Widget
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () => controller.sendMessage(),
                            child: const Text("Send Text")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller.sendButtonMessage(),
                            child: const Text("Send Button Message")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller
                                .pickFileAndSend(WhatsappFileType.image),
                            child: const Text("Send Image")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller
                                .pickFileAndSend(WhatsappFileType.audio),
                            child: const Text("Send Audio")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller
                                .pickFileAndSend(WhatsappFileType.document),
                            child: const Text("Send Document")),
                      ],
                    ),
                  ),
                  const Divider(),
                  FittedBox(
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => controller.getAllGroups(),
                            child: const Text("Get Groups")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller.getChats(),
                            child: const Text("Get Chats")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () => controller.getStatus(false),
                            child: const Text("Get Status")),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),

                  // Bottom Widgets
                  Obx(() => Text(
                        "ConnectionEvent : ${controller.connectionEvent.value?.name}",
                      )),
                  const Divider(),
                  Obx(() {
                    String? message = controller.messageEvents.value?.body;
                    String? type = controller.messageEvents.value?.type;
                    return Row(
                      children: [
                        const Text("Message : "),
                        (type == "image" || type == "video") && message != null
                            ? Image.memory(base64Decode(message))
                            : Expanded(
                                child: Text(message ?? ""),
                              ),
                      ],
                    );
                  }),
                  const Divider(),
                  Obx(() => Text(
                        "Calls : ${controller.callEvents.value?.sender}",
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

class MiddleFormView extends GetView<HomeController> {
  const MiddleFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetPlatform.isWeb
            ? TextFormField(
                controller: controller.browserClientWebSocketUrl,
                decoration: const InputDecoration(
                  labelText: "Browser client websocket url",
                ),
              )
            : const SizedBox(),
        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.phoneNumber,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Enter phone number with country code";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Phone number with country code",
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.message,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Please type a message";
                  }
                  if (!controller.connected.value) {
                    return "Please connect with Whatsapp first";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Message text",
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

class ConnectDisconnectWidget extends GetView<HomeController> {
  const ConnectDisconnectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.circle,
                color: controller.connected.value ? Colors.green : Colors.red,
              ),
            )),
        if (GetPlatform.isWeb && GetPlatform.isDesktop)
          ElevatedButton(
            onPressed: () => controller.initConnection(withExtension: true),
            child: const Text("ConnectWithExtension"),
          ),
        ElevatedButton(
          onPressed: () => controller.initConnection(),
          child: const Text("Connect"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => controller.disconnect(),
          child: const Text("Disconnect"),
        ),
      ],
    );
  }
}
