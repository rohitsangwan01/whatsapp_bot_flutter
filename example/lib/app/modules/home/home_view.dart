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
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.circle,
                    color:
                        controller.connected.value ? Colors.green : Colors.red,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Obx(() {
              return LinearProgressIndicator(
                value: (controller.progress.value / 100),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                controller.error.value,
                style: const TextStyle(color: Colors.red),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.initConnection(),
              child: const Text("Connect"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.sendMessage(context),
              child: const Text("Send Message 1"),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () => controller.sendMessage2(context),
              child: const Text("Send Message 2"),
            ),
          ],
        ));
  }
}
