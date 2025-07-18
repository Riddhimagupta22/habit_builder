import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'request_model.dart';


class RequestService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _requestRef = _firestore.collection('requests');

  static Future<void> addRequest(RequestModel request) async {
    await _requestRef.add(request.toMap());
  }

  static Future<List<RequestModel>> getUserRequests() async {
    final currentUser = _auth.currentUser;
    final snapshot = await _requestRef.where('userId', isEqualTo: currentUser?.uid).get();
    return snapshot.docs
        .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  static Future<List<RequestModel>> getAllRequests() async {
    final snapshot = await _requestRef.get();
    return snapshot.docs
        .map((doc) => RequestModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  static Future<void> updateRequestStatus(String id, String status) async {
    await _requestRef.doc(id).update({'status': status});
  }
}