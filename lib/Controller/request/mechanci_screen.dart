import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'request_controller.dart';
class MechanicRequestScreen extends StatelessWidget {
  final RequestController controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incoming Requests")),
      body: Obx(() => ListView.builder(
        itemCount: controller.mechanicRequests.length,
        itemBuilder: (context, index) {
          final req = controller.mechanicRequests[index];
          return Card(
            child: ListTile(
              title: Text(req.issue),
              subtitle: Text("${req.userName} - ${req.location}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (req.status == "pending")
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        controller.updateStatus(req.id, "accepted");
                      },
                    ),
                  if (req.status == "accepted")
                    IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () {
                        controller.updateStatus(req.id, "completed");
                      },
                    ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}