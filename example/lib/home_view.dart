import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp Message Sender'),
          centerTitle: false,
          actions: [
            Row(
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => controller.disconnect(),
                  child: const Text("Disconnect"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => controller.initConnection(),
                  child: const Text("Connect"),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.circle,
                        color: controller.connected.value
                            ? Colors.green
                            : Colors.red,
                      ),
                    ))
              ],
            )
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
                  const SizedBox(height: 20),
                  // Show Error
                  Obx(() {
                    return controller.error.value.isEmpty
                        ? const SizedBox()
                        : Text(
                            controller.error.value,
                            style: const TextStyle(color: Colors.red),
                          );
                  }),
                  Row(
                    children: [
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
                              hintText: "Enter phone number with country code",
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
                              hintText: "Enter Message",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Mid Widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => controller.sendMessage(),
                          child: const Text("Send Text")),
                      ElevatedButton(
                          onPressed: () => controller.sendImage(),
                          child: const Text("Send Image")),
                      ElevatedButton(
                          onPressed: () => controller.sendAudio(),
                          child: const Text("Send Audio")),
                      ElevatedButton(
                          onPressed: () => controller.sendDocument(),
                          child: const Text("Send Document")),
                    ],
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
                  Obx(() => Text(
                        "Messages : ${controller.messageEvents.value?.body}",
                      )),
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
