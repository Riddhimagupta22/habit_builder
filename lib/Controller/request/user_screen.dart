import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'request_controller.dart';
import 'request_model.dart';

class HomeScreen extends StatelessWidget {
  final RequestController controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Requests")),
      body: Obx(() => ListView.builder(
        itemCount: controller.userRequests.length,
        itemBuilder: (context, index) {
          final req = controller.userRequests[index];
          return Card(
            child: ListTile(
              title: Text(req.issue),
              subtitle: Text("${req.location} • ${req.status}"),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open form bottom sheet / dialog
          _showRequestDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    final TextEditingController issue = TextEditingController();
    final TextEditingController location = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Report Issue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: issue, decoration: InputDecoration(labelText: "Issue")),
            TextField(controller: location, decoration: InputDecoration(labelText: "Location")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newRequest = RequestModel(
                id: '',
                userId: "USER_ID", // use real uid
                userName: "User",
                userPhone: "9876543210",
                issue: issue.text,
                location: location.text,
                status: "pending",
                timestamp: DateTime.now().toIso8601String(),
              );
              controller.addRequest(newRequest);
              Get.back();
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}