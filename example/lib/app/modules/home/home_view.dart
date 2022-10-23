import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.countryCode,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Please type countryCode";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Country Code",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller.phoneNumber,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Please type a phone number";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Phone Number",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: IconButton(
                          onPressed: () {
                            controller.sendMessage();
                          },
                          icon: const Icon(Icons.send),
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
                        onPressed: () => controller.sendImage(),
                        child: const Text("Send Image")),
                    ElevatedButton(
                        onPressed: () => controller.sendAudio(),
                        child: const Text("Send Audio")),
                    ElevatedButton(
                        onPressed: () => controller.sendDocument(),
                        child: const Text("Send Document")),
                    Obx(() => Text(
                          "ConnectionEvent : ${controller.connectionEvent.value?.name}",
                        )),
                  ],
                ),

                // Bottom Widgets
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Obx(() {
                    return LinearProgressIndicator(
                      value: (controller.progress.value / 100),
                    );
                  }),
                ),
                Obx(() {
                  return Text(
                    controller.error.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }),
                Obx(
                  () => controller.qrCode.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 200,
                          width: 200,
                          child: PrettyQr(
                            size: 300,
                            data: controller.qrCode.value,
                            roundEdges: true,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
