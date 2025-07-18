import 'package:get/get.dart';
import 'package:habit_tracker/Controller/request/request_service.dart';

import 'request_model.dart';


class RequestController extends GetxController {
  var userRequests = <RequestModel>[].obs;
  var mechanicRequests = <RequestModel>[].obs;

  @override
  void onInit() {
    fetchUserRequests();
    fetchMechanicRequests();
    super.onInit();
  }

  void fetchUserRequests() async {
    var data = await RequestService.getUserRequests();
    userRequests.assignAll(data);
  }

  void fetchMechanicRequests() async {
    var data = await RequestService.getAllRequests();
    mechanicRequests.assignAll(data);
  }

  Future<void> addRequest(RequestModel request) async {
    await RequestService.addRequest(request);
    fetchUserRequests();
  }

  Future<void> updateStatus(String id, String status) async {
    await RequestService.updateRequestStatus(id, status);
    fetchMechanicRequests();
  }
}